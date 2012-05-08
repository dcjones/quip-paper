


theme_dcjstd <- function(base_size = 12, base_family = "Helvetica")
{
    structure(
        list(
            panel.background = theme_rect(fill   = '#eaeaea',
                                          colour = '#d0d0d0'),

            panel.grid.major = theme_line(colour = "white"), 

            panel.grid.minor = theme_line(colour = "white", size = 0.25),


            axis.text.x = theme_text(family     = base_family, 
                                     size       = base_size * 0.8,
                                     lineheight = 0.9,
                                     colour     = "black", 
                                     vjust      = 1),

            axis.text.y = theme_text(family     = base_family, 
                                     size       = base_size * 0.8,
                                     lineheight = 0.9,
                                     colour     = "black", 
                                     hjust      = 1),

            axis.title.x = theme_text(family = base_family,
                                      size   = base_size, 
                                      vjust  = -0.5),

            axis.title.y = theme_text(family = base_family, 
                                      size   = base_size,
                                      angle  = 90,
                                      vjust  = 0.2)
        ),

        class = "options"
    )
}

