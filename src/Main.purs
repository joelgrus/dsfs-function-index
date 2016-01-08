module Main where

import Prelude
import Control.Monad.Aff (runAff)
import Control.Monad.Eff (Eff())
import Control.Monad.Eff.Exception (throwException)

import Data.Array (filter)
import Data.Either (either)
import Data.Foreign (toForeign)
import Data.Foreign.Class (IsForeign, readProp)
import Data.Maybe (Maybe(..))
import Data.String (contains)

import Halogen hiding (Prop())
import Halogen.HTML.Core (Prop(), eventName, handler')
import Halogen.HTML.Events.Handler (EventHandler())
import Halogen.Util
import qualified Halogen.HTML.Indexed as H
import qualified Halogen.HTML.Properties.Indexed as P
import qualified Halogen.HTML.Events.Indexed as E

import Unsafe.Coerce (unsafeCoerce)

import FunctionIndex

-- | The state consists of a collection of IndexEntries, and a search query
-- | that's used to filter the entries.
type State = {
  searchQuery :: String,
  indexEntries :: IndexEntries
}

-- | The only action is to update the searchQuery in response to user input.
data Query a = Search String a


-- | This is 100% copied from Halogen.HTML.Events.Forms
-- |   https://github.com/slamdata/purescript-halogen/blob/master/src/Halogen/HTML/Events/Forms.purs
-- | it was the only way I could come up with to get the input value on every key up event.
addForeignPropHandler :: forall f value. (IsForeign value) => String -> String -> (value -> EventHandler (f Unit)) -> Prop (f Unit)
addForeignPropHandler key prop f = handler' (eventName key) (either (const $ pure Nothing) (map Just <<< f) <<< readProp prop <<< toForeign <<< _.target)

-- | Attaches an event handler which will fire on keyup and receive the *value* of the input.
onKeyUpInput :: forall f. (String -> EventHandler (f Unit)) -> Prop (f Unit)
onKeyUpInput = addForeignPropHandler "keyup" "value"

ui :: forall g. (Functor g) => Component State Query g
ui = component render eval
  where

  render :: State -> ComponentHTML Query
  render s =
    H.div_
      [ H.input [ P.inputType P.InputText
                , P.placeholder "Filter"
                , P.autofocus true
                , P.value s.searchQuery
                -- This is totally ugly, and I hate it. The example I was
                -- following used
                --    E.onValueChange (E.input Search)
                -- but that doesn't trigger as you type, only when the value
                -- "registers". You can't just change it to E.onKeyUp, because
                -- that generates a KeyboardEvent which itself gives no easy
                -- way to get at the input value.
                , unsafeCoerce $ onKeyUpInput (E.input Search) ]
      , H.table_
          [
            H.thead_
              [
                H.tr_
                  [ H.th_ [H.text "chapter"],
                    H.th_ [H.text "page"],
                    H.th_ [H.text "function"]
                  ]
              ]
          , H.tbody_ (map makeTableRow filteredEntries)
          ]
      ]
    where
    makeTableRow entry =
      H.tr_
        [
          H.td_ [H.text (show entry.chapter)],
          H.td_ [H.text (show entry.page)],
          H.td_ [H.text entry.function]
        ]
    -- only show entries whose function name contains the search query
    filteredEntries = filter isMatch s.indexEntries
    isMatch entry = contains s.searchQuery entry.function

  eval :: Natural Query (ComponentDSL State Query g)
  eval (Search s next) = do
    modify (\state -> state { searchQuery = s})
    pure next

main :: Eff (HalogenEffects ()) Unit
main = runAff throwException (const (pure unit)) $ do
  app <- runUI ui { searchQuery : "", indexEntries : indexEntries }
  onLoad $ appendToBody app.node
