## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
  )
set.seed(46709394)

## -----------------------------------------------------------------------------
library(oolong)
library(keyATM)
library(quanteda)
library(dplyr)

## ----example------------------------------------------------------------------
abstracts_keyatm

## ----createtest---------------------------------------------------------------
oolong_test <- wi(abstracts_keyatm, userid = "Hadley")
oolong_test

## ---- eval = FALSE------------------------------------------------------------
#  oolong_test$do_word_intrusion_test()

## ---- include = FALSE---------------------------------------------------------
### Mock this process
oolong_test$.__enclos_env__$private$test_content$wi$answer <- oolong_test$.__enclos_env__$private$test_content$wi$intruder
oolong_test$.__enclos_env__$private$test_content$wi$answer[1] <- "wronganswer"

## ----lock---------------------------------------------------------------------
oolong_test$lock()
oolong_test

## ----wsi1---------------------------------------------------------------------
oolong_test <- wsi(abstracts_keyatm, userid = "Garrett")
oolong_test

## ----wsi2, eval = FALSE-------------------------------------------------------
#  oolong_test$do_word_set_intrusion_test()

## ---- include = FALSE---------------------------------------------------------
### Mock this process
oolong_test$.__enclos_env__$private$test_content$wsi$answer <- oolong_test$.__enclos_env__$private$test_content$wsi$intruder
oolong_test$.__enclos_env__$private$test_content$wsi$answer[1] <- "wronganswer"

## ----wsi3---------------------------------------------------------------------
oolong_test$lock()
oolong_test

## ----newgroup5----------------------------------------------------------------
library(tibble)
abstracts

## ----createtest2--------------------------------------------------------------
oolong_test <- ti(abstracts_keyatm, abstracts$text, userid = "Julia")
oolong_test

## ---- eval = FALSE------------------------------------------------------------
#  oolong_test$do_topic_intrusion_test()
#  oolong_test$lock()

## ---- include = FALSE---------------------------------------------------------
genius_topic <- function(obj1) {
    obj1$.__enclos_env__$private$test_content$ti$answer <- obj1$.__enclos_env__$private$test_content$ti$intruder
    return(obj1)
}
genius_word <- function(obj1) {
    obj1$.__enclos_env__$private$test_content$wi$answer <- obj1$.__enclos_env__$private$test_content$wi$intruder
    return(obj1)
}
oolong_test <- genius_word(genius_topic(oolong_test))
oolong_test$.__enclos_env__$private$test_content$ti$answer[2] <- sample(oolong_test$.__enclos_env__$private$test_content$ti$candidates[[2]], 1)
oolong_test$lock()

## ----topic_res----------------------------------------------------------------
oolong_test

## ---- eval = FALSE------------------------------------------------------------
#  dfm(abstracts$text, tolower = TRUE, stem = TRUE, remove = stopwords('english'), remove_punct = TRUE, remove_numbers = TRUE, remove_symbols = TRUE, remove_hyphens = TRUE) %>% dfm_trim(min_docfreq = 3, max_docfreq = 500) %>% dfm_select(min_nchar = 3, pattern = "^[a-zA-Z]+$", valuetype = "regex") -> abstracts_dfm

## ----step0, eval = FALSE------------------------------------------------------
#  require(keyATM)
#  abstracts_keyatm <- keyATM(keyATM_read(abstracts_dfm), no_keyword_topics = 0, keywords = abstracts_dictionary, model = "base", options = list(seed = 46709394))

## ----step1--------------------------------------------------------------------
oolong_test_rater1 <- witi(abstracts_keyatm, abstracts$text, userid = "Yihui")

## ----step2--------------------------------------------------------------------
oolong_test_rater2 <- clone_oolong(oolong_test_rater1, userid = "Jenny")

## ---- eval = FALSE------------------------------------------------------------
#  ## Let Yihui do the test.
#  oolong_test_rater1$do_word_intrusion_test()
#  oolong_test_rater1$do_topic_intrusion_test()
#  oolong_test_rater1$lock()
#  
#  ## Let Jenny do the test.
#  oolong_test_rater2$do_word_intrusion_test()
#  oolong_test_rater2$do_topic_intrusion_test()
#  oolong_test_rater2$lock()

## ---- include = FALSE---------------------------------------------------------
### Mock this process
set.seed(46709394)
oolong_test_rater1 <- oolong:::.monkey_test(oolong_test_rater1, intelligent = 0.3)
oolong_test_rater2 <- oolong:::.monkey_test(oolong_test_rater2, intelligent = 0)
oolong_test_rater1$lock()
oolong_test_rater2$lock()

## ---- step3-------------------------------------------------------------------
summarize_oolong(oolong_test_rater1, oolong_test_rater2)

## -----------------------------------------------------------------------------
wi(newsgroup_nb)

## -----------------------------------------------------------------------------
wsi(newsgroup_nb)

## ----trump2k------------------------------------------------------------------
tibble(text = trump2k)

## ----goldstandard-------------------------------------------------------------
oolong_test <- gs(input_corpus = trump2k, construct = "positive", userid = "Joe")
oolong_test

## ---- eval = FALSE------------------------------------------------------------
#  oolong_test$do_gold_standard_test()

## ---- include = FALSE---------------------------------------------------------
oolong_test$.__enclos_env__$private$test_content$gs <- 
structure(list(case = 1:20, text = c("Thank you Eau Claire, Wisconsin. \n#VoteTrump on Tuesday, April 5th!\nMAKE AMERICA GREAT AGAIN! https://t.co/JI5JqwHnMC", 
"\"@bobby990r_1: @realDonaldTrump would lead polls the second he announces candidacy! America is waiting for him to LEAD us out of this mess!", 
"\"@KdanielsK: @misstcassidy @AllAboutTheTea_ @realDonaldTrump My money is on Kenya getting fired first.\"", 
"Thank you for a great afternoon Birmingham, Alabama! #Trump2016 #MakeAmericaGreatAgain https://t.co/FrOkqCzBoD", 
"\"@THETAINTEDT: @foxandfriends @realDonaldTrump Trump 2016 http://t.co/UlQWGKUrCJ\"", 
"People believe CNN these days almost as little as they believe Hillary....that's really saying something!", 
"It was great being in Michigan. Remember, I am the only presidential candidate who will bring jobs back to the U.S.and protect car industry!", 
"\"@DomineekSmith: @realDonaldTrump is the best Republican presidential candidate of all time.\"  Thank you.", 
"Word is that little Morty Zuckerman’s @NYDailyNews loses more than $50 million per year---can that be possible?", 
"\"@Chevy_Mama: @realDonaldTrump I'm obsessed with @celebrityapprenticeNBC. Honestly,  Mr Trump, you are very inspiring\"", 
"President Obama said \"ISIL continues to shrink\" in an interview just hours before the horrible attack in Paris. He is just so bad! CHANGE.", 
".@HillaryClinton loves to lie. America has had enough of the CLINTON'S! It is time to #DrainTheSwamp! Debates https://t.co/3Mz4T7qTTR", 
"\"@jerrimoore: @realDonaldTrump awesome. A treat to get to see the brilliant Joan Rivers once more #icon\"", 
"\"@shoegoddesss: @realDonaldTrump Will definitely vote for you. Breath of fresh air. America needs you!\"", 
"Ted is the ultimate hypocrite. Says one thing for money, does another for votes. \nhttps://t.co/hxdfy0mjVw", 
"\"@Lisa_Milicaj: Truth be told, I  never heard of The National Review until they \"tried\" to declare war on you. No worries, you got my vote!\"", 
"THANK YOU Daytona Beach, Florida!\n#MakeAmericaGreatAgain https://t.co/IAcLfXe463", 
"People rarely say that many conservatives didn’t vote for Mitt Romney. If I can get them to vote for me, we win in a landslide.", 
"Trump National Golf Club, Washington, D.C. is on 600 beautiful acres fronting the Potomac River. A fantastic setting! http://t.co/pYtkbyKwt5", 
"\"@DRUDGE_REPORT: REUTERS 5-DAY ROLLING POLL: TRUMP 34%, CARSON 19.6%, RUBIO 9.7%, CRUZ 7.7%...\" Thank you - a great honor!"
), answer = c(4L, 4L, 2L, 5L, 3L, 2L, 4L, 5L, 2L, 4L, 1L, 1L, 
4L, 4L, 2L, 4L, 4L, 4L, 4L, 4L), target_value = c(NA, NA, NA, 
NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 
NA)), row.names = c(NA, -20L), class = c("tbl_df", "tbl", "data.frame"
))

## ----gs_locking---------------------------------------------------------------
oolong_test$lock()
oolong_test

## -----------------------------------------------------------------------------
oolong_test$turn_gold()

## -----------------------------------------------------------------------------
gold_standard <- oolong_test$turn_gold()
dfm(gold_standard, remove_punct = TRUE) %>% dfm_lookup(afinn) %>% quanteda::convert(to = "data.frame") %>%
    mutate(matching_word_valence = (neg5 * -5) + (neg4 * -4) + (neg3 * -3) + (neg2 * -2) + (neg1 * -1)
           + (zero * 0) + (pos1 * 1) + (pos2 * 2) + (pos3 * 3) + (pos4 * 4) + (pos5 * 5),
           base = ntoken(gold_standard, remove_punct = TRUE), afinn_score = matching_word_valence / base) %>%
    pull(afinn_score) -> all_afinn_score
all_afinn_score

## -----------------------------------------------------------------------------
summarize_oolong(oolong_test, target_value = all_afinn_score)

## -----------------------------------------------------------------------------
trump <- gs(input_corpus = trump2k, exact_n = 40, userid = "JJ")
trump2 <- clone_oolong(trump, userid = "Winston")

## ---- eval = FALSE------------------------------------------------------------
#  trump$do_gold_standard_test()
#  trump2$do_gold_standard_test()
#  trump$lock()
#  trump2$lock()

## ---- include = FALSE---------------------------------------------------------
trump$.__enclos_env__$private$test_content$gs <- 
structure(list(case = 1:20, text = c("Thank you Eau Claire, Wisconsin. \n#VoteTrump on Tuesday, April 5th!\nMAKE AMERICA GREAT AGAIN! https://t.co/JI5JqwHnMC", 
"\"@bobby990r_1: @realDonaldTrump would lead polls the second he announces candidacy! America is waiting for him to LEAD us out of this mess!", 
"\"@KdanielsK: @misstcassidy @AllAboutTheTea_ @realDonaldTrump My money is on Kenya getting fired first.\"", 
"Thank you for a great afternoon Birmingham, Alabama! #Trump2016 #MakeAmericaGreatAgain https://t.co/FrOkqCzBoD", 
"\"@THETAINTEDT: @foxandfriends @realDonaldTrump Trump 2016 http://t.co/UlQWGKUrCJ\"", 
"People believe CNN these days almost as little as they believe Hillary....that's really saying something!", 
"It was great being in Michigan. Remember, I am the only presidential candidate who will bring jobs back to the U.S.and protect car industry!", 
"\"@DomineekSmith: @realDonaldTrump is the best Republican presidential candidate of all time.\"  Thank you.", 
"Word is that little Morty Zuckerman’s @NYDailyNews loses more than $50 million per year---can that be possible?", 
"\"@Chevy_Mama: @realDonaldTrump I'm obsessed with @celebrityapprenticeNBC. Honestly,  Mr Trump, you are very inspiring\"", 
"President Obama said \"ISIL continues to shrink\" in an interview just hours before the horrible attack in Paris. He is just so bad! CHANGE.", 
".@HillaryClinton loves to lie. America has had enough of the CLINTON'S! It is time to #DrainTheSwamp! Debates https://t.co/3Mz4T7qTTR", 
"\"@jerrimoore: @realDonaldTrump awesome. A treat to get to see the brilliant Joan Rivers once more #icon\"", 
"\"@shoegoddesss: @realDonaldTrump Will definitely vote for you. Breath of fresh air. America needs you!\"", 
"Ted is the ultimate hypocrite. Says one thing for money, does another for votes. \nhttps://t.co/hxdfy0mjVw", 
"\"@Lisa_Milicaj: Truth be told, I  never heard of The National Review until they \"tried\" to declare war on you. No worries, you got my vote!\"", 
"THANK YOU Daytona Beach, Florida!\n#MakeAmericaGreatAgain https://t.co/IAcLfXe463", 
"People rarely say that many conservatives didn’t vote for Mitt Romney. If I can get them to vote for me, we win in a landslide.", 
"Trump National Golf Club, Washington, D.C. is on 600 beautiful acres fronting the Potomac River. A fantastic setting! http://t.co/pYtkbyKwt5", 
"\"@DRUDGE_REPORT: REUTERS 5-DAY ROLLING POLL: TRUMP 34%, CARSON 19.6%, RUBIO 9.7%, CRUZ 7.7%...\" Thank you - a great honor!"
), answer = c(4L, 4L, 2L, 5L, 3L, 2L, 4L, 5L, 2L, 4L, 1L, 1L, 
4L, 4L, 2L, 4L, 4L, 4L, 4L, 4L), target_value = c(NA, NA, NA, 
NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 
NA)), row.names = c(NA, -20L), class = c("tbl_df", "tbl", "data.frame"
                                         ))

trump2$.__enclos_env__$private$test_content$gs <- 
structure(list(case = 1:20, text = c("Thank you Eau Claire, Wisconsin. \n#VoteTrump on Tuesday, April 5th!\nMAKE AMERICA GREAT AGAIN! https://t.co/JI5JqwHnMC", 
"\"@bobby990r_1: @realDonaldTrump would lead polls the second he announces candidacy! America is waiting for him to LEAD us out of this mess!", 
"\"@KdanielsK: @misstcassidy @AllAboutTheTea_ @realDonaldTrump My money is on Kenya getting fired first.\"", 
"Thank you for a great afternoon Birmingham, Alabama! #Trump2016 #MakeAmericaGreatAgain https://t.co/FrOkqCzBoD", 
"\"@THETAINTEDT: @foxandfriends @realDonaldTrump Trump 2016 http://t.co/UlQWGKUrCJ\"", 
"People believe CNN these days almost as little as they believe Hillary....that's really saying something!", 
"It was great being in Michigan. Remember, I am the only presidential candidate who will bring jobs back to the U.S.and protect car industry!", 
"\"@DomineekSmith: @realDonaldTrump is the best Republican presidential candidate of all time.\"  Thank you.", 
"Word is that little Morty Zuckerman’s @NYDailyNews loses more than $50 million per year---can that be possible?", 
"\"@Chevy_Mama: @realDonaldTrump I'm obsessed with @celebrityapprenticeNBC. Honestly,  Mr Trump, you are very inspiring\"", 
"President Obama said \"ISIL continues to shrink\" in an interview just hours before the horrible attack in Paris. He is just so bad! CHANGE.", 
".@HillaryClinton loves to lie. America has had enough of the CLINTON'S! It is time to #DrainTheSwamp! Debates https://t.co/3Mz4T7qTTR", 
"\"@jerrimoore: @realDonaldTrump awesome. A treat to get to see the brilliant Joan Rivers once more #icon\"", 
"\"@shoegoddesss: @realDonaldTrump Will definitely vote for you. Breath of fresh air. America needs you!\"", 
"Ted is the ultimate hypocrite. Says one thing for money, does another for votes. \nhttps://t.co/hxdfy0mjVw", 
"\"@Lisa_Milicaj: Truth be told, I  never heard of The National Review until they \"tried\" to declare war on you. No worries, you got my vote!\"", 
"THANK YOU Daytona Beach, Florida!\n#MakeAmericaGreatAgain https://t.co/IAcLfXe463", 
"People rarely say that many conservatives didn’t vote for Mitt Romney. If I can get them to vote for me, we win in a landslide.", 
"Trump National Golf Club, Washington, D.C. is on 600 beautiful acres fronting the Potomac River. A fantastic setting! http://t.co/pYtkbyKwt5", 
"\"@DRUDGE_REPORT: REUTERS 5-DAY ROLLING POLL: TRUMP 34%, CARSON 19.6%, RUBIO 9.7%, CRUZ 7.7%...\" Thank you - a great honor!"
), answer = c(5L, 3L, 2L, 5L, 3L, 1L, 4L, 5L, 2L, 4L, 1L, 1L, 
4L, 4L, 2L, 4L, 4L, 4L, 4L, 4L), target_value = c(NA, NA, NA, 
NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 
NA)), row.names = c(NA, -20L), class = c("tbl_df", "tbl", "data.frame"
                                         ))
trump$lock()
trump2$lock()

## -----------------------------------------------------------------------------
gold_standard <- trump$turn_gold()
dfm(gold_standard, remove_punct = TRUE) %>% dfm_lookup(afinn) %>% quanteda::convert(to = "data.frame") %>%
    mutate(matching_word_valence = (neg5 * -5) + (neg4 * -4) + (neg3 * -3) + (neg2 * -2) + (neg1 * -1)
           + (zero * 0) + (pos1 * 1) + (pos2 * 2) + (pos3 * 3) + (pos4 * 4) + (pos5 * 5),
           base = ntoken(gold_standard, remove_punct = TRUE), afinn_score = matching_word_valence / base) %>%
    pull(afinn_score) -> target_value

## -----------------------------------------------------------------------------
res <- summarize_oolong(trump, trump2, target_value = target_value)

## -----------------------------------------------------------------------------
res

## ----diagnosis----------------------------------------------------------------
plot(res)

