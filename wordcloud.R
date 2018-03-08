library("tm")
library("wordcloud")
library("RColorBrewer")

# Write to file dataframe column with text of interest
# write.table(df$textStr,"wordcloud.txt", sep="\t",row.names=FALSE)

# Or simply read from txt file
filePath <- '../wordcloud.txt'
text <- read.delim(filePath, sep = "\t")

docs.corpus <- VCorpus(VectorSource(text))
docs.corpus <- tm_map(docs.corpus, removePunctuation)
docs.corpus <- tm_map(docs.corpus, content_transformer(tolower))
docs.corpus <- tm_map(docs.corpus, function(x) removeWords(x, stopwords("english")))
tdm <- TermDocumentMatrix(docs.corpus)
m <- as.matrix(tdm)
v <- sort(rowSums(m),decreasing = TRUE)
d <- data.frame(word = names(v),freq=v)

png(".../wordcloud.png", width=1280, height=800)
wordcloud(words = d$word,freq = d$freq, min.freq=2,max.words=100, random.order=F, rot.per=.15,
          colors=brewer.pal(8, "Dark2"))
dev.off()
