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
upes.tweets = searchTwitter('apple', n=1000, lang="en")
upes.tweets
class(upes.tweets)
utweet = upes.tweets[[1]]
utweet
class(utweet)
utweet$getText()
library(plyr)
upes.text = laply(upes.tweets, function(t) t$getText() )
upes.text
upestexts = upes.text[1:1000]
class(upestexts)
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

checkupes = upestexts[1:1000]
resultupes = score.sentiment(checkupes, pos.words, neg.words)

mean(resultupes$score)

plot(resultupes)

upestexts <- gsub("rt", "", upestexts)
upestexts <- gsub("@\\w+", "", upestexts)
upestexts <- gsub("[[:punct:]]", "", upestexts)
upestexts <- gsub("http\\w+", "", upestexts)
upestexts <- gsub("[ |\t]{2,}", "", upestexts)
upestexts <- gsub("^ ", "", upestexts)
upestexts <- gsub(" $", "", upestexts)
upestexts.corpus <- Corpus(VectorSource(upestexts))
upestexts.corpus <- tm_map(upestexts.corpus, function(x)removeWords(x,stopwords()))
wordcloud(upestexts.corpus,min.freq = 2, scale=c(7,0.5),colors=brewer.pal(8, "Dark2"),  random.color= TRUE, random.order = FALSE, max.words = 150)
