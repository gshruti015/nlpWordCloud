library(twitteR)
library(tm)
library(wordcloud)
library(RColorBrewer)

#CONNECT TO TWITTER
setup_twitter_oauth('MbTpLWjPMkqxvLn1ckeY9oant','7vPHNOy625GlFIhD6qHBdxGtY4i4nl5Y80QBDvdBvPYPMSwnsF','2904866593-odP7vx2tbvqppw0hZmWTlMjRUOoZAwWjAbELsR3','EQ1m1C0Mhy3lfQxeG0Ce9AVP3uvpW61foPpGYR5CtztMX')
subject_tweets<-searchTwitter('Budget2019',n=1000,lang='en')

#get text data from the tweets
subject.text<-sapply(subject_tweets,function(x) x$getText())

#clean text data
subject.text <- iconv(subject.text,'utf-8','ASCII') #remove emoticons
subject.corpus<-Corpus(VectorSource(subject.text))
term.matrix<-TermDocumentMatrix(subject.corpus,control=list(removePunctuation=TRUE,
                                                           stopwords=c('budget','https',stopwords('english')),
                                                           removeNumbers=TRUE,tolower=TRUE))
term.matrix<-as.matrix(term.matrix)
#word counts
word.freq<-sort(rowSums(term.matrix),decreasing = TRUE)
dm<-data.frame(word=names(word.freq),freq=word.freq)
wordcloud(dm$word,dm$freq,random.order = FALSE,colors=brewer.pal(8,'Dark2'), size=0.3)
