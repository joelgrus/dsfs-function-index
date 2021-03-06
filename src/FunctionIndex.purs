module FunctionIndex where

import Prelude

import Data.Array.Unsafe (unsafeIndex)
import Data.Int (fromString)
import Data.Maybe.Unsafe (fromJust)
import Data.String (split)

type IndexEntry = {
  chapter :: Int,     -- the chapter where the function is defined
  page :: Int,        -- the page where the function is defined
  function :: String  -- the name of the function
}

showEntry :: IndexEntry -> String
showEntry entry = show entry.chapter ++ " " ++ show entry.page ++ " " ++ entry.function

type IndexEntries = Array IndexEntry

-- | Turn a comma-separated string "chapter,page,function" into an IndexEntry
-- | object. Doesn't do any sort of error checking. :(
makeEntry :: String -> IndexEntry
makeEntry line = { chapter : c, page : p, function : f }
  where
    fields = split "," line
    c = fromJust $ fromString $ unsafeIndex fields 0
    p = fromJust $ fromString $ unsafeIndex fields 1
    f = unsafeIndex fields 2

indexEntries :: IndexEntries
indexEntries = map makeEntry $ split "\n" rawData

-- | In an ideal world this would live in a separate CSV file, but that caused
-- | me all sorts of browserify-related grief, so now it's hardcoded.
rawData :: String
rawData = """4,50,vector_add
4,51,vector_subtract
4,51,vector_sum
4,51,scalar_multiply
4,51,vector_mean
4,51,dot
4,52,sum_of_squares
4,52,magnitude
4,53,squared_distance
4,53,distance
4,53,shape
4,54,get_row
4,54,get_column
4,54,make_matrix
4,54,is_diagonal
5,59,mean
5,59,median
5,60,quantile
5,60,mode
5,61,data_range
5,61,de_mean
5,61,variance
5,62,standard_deviation
5,62,interquartile_range
5,62,covariance
5,63,correlation
6,71,random_kid
6,74,uniform_pdf
6,74,uniform_cdf
6,75,normal_pdf
6,77,normal_cdf
6,78,inverse_normal_cdf
6,79,bernoulli_trial
6,79,binomial
6,79,make_hist
7,82,normal_approximation_to_binomial
7,82,normal_probability_below
7,82,normal_probability_above
7,82,normal_probability_between
7,82,normal_probability_outside
7,82,normal_upper_bound
7,82,normal_lower_bound
7,82,normal_two_sided_bounds
7,84,two_sided_p_value
7,86,run_experiment
7,86,reject_fairness
7,88,estimated_parameters
7,88,a_b_test_statistic
7,89,B
7,89,beta_pdf
8,93,sum_of_squares
8,94,difference_quotient
8,95,square
8,95,derivative
8,96,partial_difference_quotient
8,97,estimate_gradient
8,97,step
8,97,sum_of_squares_gradient
8,98,safe
8,98,minimize_batch
8,99,negate
8,99,negate_all
8,99,maximize_batch
8,99,in_random_order
8,100,minimize_stochastic
8,100,maximize_stochastic
9,111,is_video
9,112,book_info
9,113,get_year
10,122,bucketize
10,122,make_histogram
10,122,plot_histogram
10,123,random_normal
10,125,correlation_matrix
10,128,parse_row
10,128,parse_rows_with
10,128,try_or_none
10,129,try_parse_field
10,129,parse_dict
10,130,picker
10,130,pluck
10,130,group_by
10,131,percent_price_change
10,131,day_over_day_changes
10,133,scale
10,133,rescale
10,135,de_mean_matrix
10,135,direction
10,136,directional_variance_i
10,136,directional_variance
10,136,directional_variance_gradient_i
10,136,directional_variance_gradient
10,136,first_principal_component
10,136,first_principal_component_sgd
10,137,project
10,137,remove_projection_from_vector
10,137,remove_projection
10,138,principal_component_analysis
10,138,transform_vector
10,138,transform
11,144,split_data
11,144,train_test_split
11,146,accuracy
11,146,precision
11,146,recall
11,146,f1_score
12,152,raw_majority_vote
12,152,majority_vote
12,153,knn_classify
12,157,random_point
12,157,random_distances
13,168,tokenize
13,168,count_words
13,168,word_probabilities
13,168,spam_probability
13,169,NaiveBayesClassifier
13,171,p_spam_given_word
13,171,drop_final_s
14,174,predict
14,174,error
14,174,sum_of_squared_errors
14,174,least_squares_fit
14,175,total_sum_of_squares
14,175,r_squared
14,176,squared_error
14,176,squared_error_gradient
15,181,error
15,181,squared_error
15,182,squared_error_gradient
15,182,estimate_beta
15,183,multiple_r_squared
15,184,bootstrap_sample
15,184,bootstrap_statistic
15,185,estimate_sample_beta
15,185,p_value
15,186,ridge_penalty
15,186,squared_error_ridge
15,187,ridge_penalty_gradient
15,187,squared_error_ridge_gradient
15,187,estimate_beta_ridge
15,188,lasso_penalty
16,192,logistic
16,192,logistic_prime
16,193,logistic_log_likelihood_i
16,193,logistic_log_likelihood
16,194,logistic_log_partial_ij
16,194,logistic_log_gradient_i
16,194,logistic_log_gradient
17,204,entropy
17,205,class_probabilities
17,205,data_entropy
17,205,partition_entropy
17,207,partition_by
17,207,partition_entropy_by
17,209,classify
17,209,build_tree_id3
17,211,forest_classify
18,213,step_function
18,213,perceptron_output
18,215,sigmoid
18,216,neuron_output
18,217,feed_forward
18,219,backpropagate
18,221,predict
18,222,patch
19,226,KMeans
19,230,squared_clustering_errors
19,234,is_leaf
19,234,get_children
19,234,get_values
19,234,cluster_distance
19,234,get_merge_order
19,234,bottom_up_cluster
19,236,generate_clusters
20,240,text_size
20,242,fix_unicode
20,242,generate_using_bigrams
20,243,generate_using_trigrams
20,245,expand
20,246,roll_a_die
20,246,direct_sample
20,247,random_y_given_x
20,247,random_x_given_y
20,247,gibbs_sample
20,247,compare_distributions
20,249,sample_from
20,250,p_topic_given_document
20,250,p_word_given_topic
20,250,topic_weight
20,251,choose_new_topic
21,257,shortest_paths_from
21,259,farness
21,260,matrix_product_entry
21,260,matrix_mutiply
21,261,vector_as_matrix
21,261,vector_from_matrix
21,261,matrix_operate
21,261,find_eigenvector
21,262,entry_fn
21,265,page_rank
22,268,most_popular_new_interests
22,269,cosine_similarity
22,270,make_user_interest_vector
22,270,most_similar_users_to
22,271,user_based_suggestions
22,272,most_similar_interests_to
22,273,item_based_suggestions
23,276,Table
23,277,Table.update
23,278,Table.delete
23,279,Table.select
23,279,Table.where
23,279,Table.limit
23,281,Table.group_by
23,281,min_user_id
23,282,first_letter_of_name
23,282,average_num_friends
23,282,enough_friends
23,282,Table.order_by
23,284,Table.join
23,285,count_interests
24,290,word_count_old
24,290,wc_mapper
24,290,wc_reducer
24,290,word_count
24,292,map_reduce
24,292,reduce_values_using
24,292,values_reducer
24,292,sum_reducer
24,292,max_reducer
24,292,min_reducer
24,292,count_distinct_reducer
24,293,data_science_day_mapper
24,293,words_per_user_mapper
24,294,most_popular_word_reducer
24,294,liker_mapper
24,295,matrix_multiply_mapper
24,295,matrix_multiply_reducer"""
