

shinyServer(function(input, output){
  # show map using googleVis
  output$usage <- renderPlot(
    usage %>%
      ggplot(aes(x = "", y = count, fill=type)) +
      geom_bar(width = 1, stat = "identity")+
      coord_polar("y", start=0) +
      scale_fill_brewer(palette="YlGnBu")+
      theme_minimal()+
      ggtitle("Number of Usage")+
      theme(text = element_text(size=20), 
            plot.title = element_text(hjust = 0.5),
            panel.background = element_rect(fill = "lightblue",
                                            colour = "lightblue",
                                            size = 0.5, linetype = "solid"))+
      labs(x="", y = "count of Python users from 10,000")
  )
  output$language <- renderPlot(
 #   division %>%
#      arrange(ratio) %>%
 #     mutate(names=factor(names,names)) %>%
  #    ggplot(aes(x = names, y = ratio, fill = names)) +
   #   geom_bar(stat = "identity", position = "stack", width = 0.5)+
    #  scale_fill_brewer(palette="Paired")+
     # ggtitle("Python with other language")+
      #theme(text = element_text(size=15), plot.title = element_text(hjust = 0.5))
    
    division %>%
       arrange(ratio) %>%
      mutate(names=factor(names,names)) %>%
      ggplot( aes(x=names, y=ratio)) +
      geom_segment( aes(x=names, xend=names, y=0, yend=ratio), color="skyblue", size=1) +
      geom_point( color="blue", size=4, alpha=0.6) +
      theme_light() +
      ggtitle("Ratio of top 9 number of language users other than Python")+
      theme(
        panel.grid.major.y = element_blank(),
        panel.border = element_blank(),
        axis.ticks.y = element_blank(),
        text = element_text(size=20), 
        plot.title = element_text(hjust = 0.5)
      )+
      labs(x="languages other than Python", y = "ratio")
  )
  output$Purpose <- renderPlot(
 #   p %>%
 #     arrange(pratio) %>%
  #    mutate(pnames=factor(pnames,pnames)) %>%
  #    ggplot(aes(x = pnames, y = pratio, fill = pnames)) +
   #   geom_bar(stat="identity")+
   #   coord_flip()+
   #   ggtitle("Python with other language")+
    #  theme(text = element_text(size=15), plot.title = element_text(hjust = 0.5))
    
    p %>%
      arrange(pratio) %>%
      mutate(pnames=factor(pnames,pnames)) %>%
      ggplot(aes(x = pnames, y = pratio, fill = pnames)) +
      geom_bar(stat="identity") +
      ylim(0,0.5) +
      theme_minimal() +
      ggtitle("Ratio of top 12 ways of using Python")+
      theme(
        axis.text.x=element_blank(),
        text = element_text(size=20), 
        plot.title = element_text(hjust = 0.5)
      ) +
      coord_polar()+
      labs(fill="Purpose",x="", y = "ratio")
  )
  output$Purpose2 <- renderPlot(
    p %>%
      arrange(pnumber) %>%
      mutate(pnames=factor(pnames,pnames)) %>%
      ggplot(aes(x = pnames, y = pnumber, fill = pnames)) +
      geom_bar(stat="identity", alpha=0.8, width = 0.5) +
      theme_minimal() +
      theme(
        panel.grid = element_blank(),
        text = element_text(size=20), 
        plot.title = element_text(hjust = 0.5)
      )+
      scale_x_discrete(labels = function(x) str_wrap(x, width = 10))+
      labs(fill="Purpose", x="Purpose", y = "number")
  )
  output$Industry <- renderPlot(
    Industry %>%
      arrange(desc(ratio)) %>%
      mutate(industry=factor(industry,industry)) %>%
      ggplot(aes(x = industry, y = ratio, fill = industry)) +
      geom_bar(stat="identity", alpha=0.5, width = 0.5) +
      ylim(0,0.3) +
      theme_minimal() +
      theme(
        panel.grid = element_blank(),
        text = element_text(size=20), 
        plot.title = element_text(hjust = 0.5)
      )+
      scale_x_discrete(labels = function(x) str_wrap(x, width = 10))+
      ggtitle("Ratio of Python using in the top 12 industries")
  )
  output$Country <- renderPlot(
    ggplot() +
      geom_map(data=WorldData, map=WorldData,
               aes(group=group, map_id=region),
               fill="white", colour="#7f7f7f", size=0.5)+
      geom_map(data=Country, map=WorldData,
               aes(fill=number, map_id=country),
               colour="#7f7f7f", size=0.5)+
      coord_map("rectangular", lat0=0, xlim=c(-180,180), ylim=c(-60, 90))+
      scale_fill_continuous(low="#E0FFFF", high="#4169E1", 
                            guide="colorbar")+
      scale_y_continuous(breaks=c())+
      scale_x_continuous(breaks=c())+
      labs(fill="number", title="Python Users in global community", x="Countries", y="number of Python users")+
      theme_bw()+
      theme(panel.border = element_blank(),        
            text = element_text(size=20), 
            plot.title = element_text(hjust = 0.5))+
      expand_limits(x = WorldData$long, y = WorldData$lat)
   
  )
  
  output$Country2 <- renderPlot(
    Country %>%
      arrange(., desc(number)) %>% head(15) %>%
      mutate(country=factor(country,country)) %>%
      ggplot(aes(x = country, y = number, fill = country)) +
      geom_bar(stat="identity", alpha=0.5, width = 0.5) +
      ylim(0,3300) +
      theme_minimal() +
      theme(
        panel.grid = element_blank(),
        text = element_text(size=20), 
        plot.title = element_text(hjust = 0.5)
      )+
      scale_x_discrete(labels = function(x) str_wrap(x, width = 10))+
      labs(fill="Country",x="Countries", y="number of Python users", title="Top 10 Countries that has most Python Users")
  )
  
  output$Age <- renderPlot(
    age %>% 
      ggplot(aes(fill=range, ymax=ymax, ymin=ymin, xmax=4, xmin=3))+
      geom_rect() +
      coord_polar(theta="y") +
      xlim(c(0, 4)) +
      theme_light() +
      theme(
        axis.text = element_blank(),
        panel.grid = element_blank(),
        text = element_text(size=20), 
        plot.title = element_text(hjust = 0.5),
        panel.background = element_rect(fill = "lightblue",
                                        colour = "lightblue",
                                        size = 0.5, linetype = "solid")
      )+
      labs(fill="Range",title = "Distribution of Python user in age range")
  )
  output$Age2 <- renderPlot(
    age %>% 
      ggplot(aes(x = range, y = number, fill = range)) +
      geom_bar(stat="identity", alpha=0.8, width = 0.5) +
      theme_minimal() +
      theme(
        panel.grid = element_blank(),
        text = element_text(size=20), 
        plot.title = element_text(hjust = 0.5),
        panel.background = element_rect(fill = "lightblue",
                                        colour = "lightblue",
                                        size = 0.5, linetype = "solid")
      )+
      scale_x_discrete(labels = function(x) str_wrap(x, width = 10))+
      labs(x="Age Range", y = "number")
  )
  

})