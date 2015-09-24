library(twitteR)
library(bitops)
library(RCurl)
consumer_key <- 'qAOPcAP3tAuTHzYcwjlGWsaGz'
consumer_secret <- 'cdad2o3AEsiuLgGixr9JKTtpRea7h7Ul2VnN5AMhuqqXfuI4rl'
access_secret <- '100759949-au1vGhg9bKXx1Iy76JZCli8lLrb7iFjK7DPDAyoB'
access_token <- 'ggcTsw9H0uSca9W4qBf1vqepDqh5P1iNUz5qiM8wmrj4B'
setup_twitter_oauth(consumer_key, consumer_secret, access_secret, access_token)
nestle.tweets = searchTwitter('nestle', n=1500, lang="en")
nestle.tweets
class(nestle.tweets)
ntweet = nestle.tweets[[1]]
ntweet
class(ntweet)
ntweet$getText()
library(plyr)
nestle.text = laply(nestle.tweets, function(t) t$getText() )
nestle.text
nestle.text[600:605]
class(nestle.text)
msg.pos = scan('C:/Users/Rohan/Desktop/CapitalMarket/positive-words.txt',
               what='character', comment.char=';')
msg.neg = scan('C:/Users/Rohan/Desktop/CapitalMarket/negative-words.txt',what='character', comment.char=';')

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

checknestle = nestle.text[600:605]
result = score.sentiment(checknestle, pos.words, neg.words)
