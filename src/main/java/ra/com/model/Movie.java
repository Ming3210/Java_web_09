package ra.com.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Movie {
    private int id;
    private String title;
    private String director;
    private String genre;
    private String description;
    private int duration;
    private String language;
}
