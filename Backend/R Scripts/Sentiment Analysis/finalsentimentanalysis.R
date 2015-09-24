install.packages("twitteR")
install.packages("bitops")
install.packages("RCurl")
install.packages("wordcloud")
install.packages("tm")
install.packages("plyr")
install.packages("stringr")

library(twitteR)
library(bitops)
library(RCurl)
library(wordcloud)
library(tm)
consumer_key <- 'qAOPcAP3tAuTHzYcwjlGWsaGz'
consumer_secret <- 'cdad2o3AEsiuLgGixr9JKTtpRea7h7Ul2VnN5AMhuqqXfuI4rl'
access_secret <- '100759949-au1vGhg9bKXx1Iy76JZCli8lLrb7iFjK7DPDAyoB'
access_token <- 'ggcTsw9H0uSca9W4qBf1vqepDqh5P1iNUz5qiM8wmrj4B'
setup_twitter_oauth(consumer_key, consumer_secret, access_secret, access_token)
company.tweets = searchTwitter('infosys', n=1500, lang="en")
company.tweets
class(company.tweets)
utweet = company.tweets[[1]]
utweet
class(utweet)
utweet$getText()
library(plyr)
company.text = laply(company.tweets, function(t) t$getText() )
company.text
companytexts = company.text[1:1500]
class(companytexts)
msg.pos = scan('positive-words.txt', what='character', comment.char=';')
msg.neg = scan('negative-words.txt', what='character', comment.char=';')

class(msg.pos)
pos.words = c(msg.pos, 'upgrade')
neg.words = c(msg.neg, 'wtf', 'wait', 'waiting', 'epicfail', 'mechanical')


score.sentiment = function(sentences, pos.words, neg.words, .progress='none')
{
  require(plyr)
  require(stringr)
  
  scores = laply(sentences, function(sentence, pos.words, neg.words) {
    
    sentence = gsub('[[:punct:]]', '', sentence)
    sentence = gsub('[[:cntrl:]]', '', sentence)
    sentence = gsub('\\d+', '', sentence)
    sentence = tolower(sentence)
    
    word.list = str_split(sentence, '\\s+')
    words = unlist(word.list)
    
    pos.matches = match(words, pos.words)
    neg.matches = match(words, neg.words)
    
    pos.matches = !is.na(pos.matches)
    neg.matches = !is.na(neg.matches)
    
    score = sum(pos.matches) - sum(neg.matches)
    
    return(score)
  }, pos.words, neg.words, .progress=.progress )
  
  scores.df = data.frame(score=scores, text=sentences)
  return(scores.df)
  
}

check = companytexts[1:1500]
result = score.sentiment(check, pos.words, neg.words)

mean(result$score)

plot(result)

companytexts <- gsub("rt", "", companytexts)
companytexts <- gsub("@\\w+", "", companytexts)
companytexts <- gsub("[[:punct:]]", "", companytexts)
companytexts <- gsub("http\\w+", "", companytexts)
companytexts <- gsub("[ |\t]{2,}", "", companytexts)
companytexts <- gsub("^ ", "", companytexts)
companytexts <- gsub(" $", "", companytexts)
companytexts.corpus <- Corpus(VectorSource(companytexts))
companytexts.corpus <- tm_map(companytexts.corpus, function(x)removeWords(x,stopwords()))
wordcloud(companytexts.corpus,min.freq = 2, scale=c(7,0.5),colors=brewer.pal(8, "Dark2"),  random.color= TRUE, random.order = FALSE, max.words = 150)
