## Brent's Spatterbox screening questions

### Note to the reader

Hello! How are you? Thanks for taking the time to check my screening
questions out.

*Did you know?* I like to do Test Driven Development. Check out the `specs` directory to see the tests that I wrote while solving these problems.
To run the specs, do a `bundle install && rake` the first time, then just `rake`. Tested with Ruby 1.9.3p0.

Every question has been decently cleaned up, but given that this is
simply a screening exam, I did not bother to write too many comments.
I've recently enjoyed writing TomDoc style comments, but it seemed
overkill for this task.

The solutions *solve the problem at hand* but there are clearly
gaping holes (ie if you put text in between html elements in question 3)
that will make them throw nasty exceptions. I hope you'll find that the code
is factored well enough that such problems would be relatively easy to address without completely tearing apart the code.

### 1. SQL Query

Find this in `/lib/count_applications.sql`

Not much to say here. Nested select seemed like the most straightforward
solution.

If you prefer, you can read the query inline here:

````sql
SELECT    students.name, ( SELECT count(*)
                           FROM applications
                           WHERE applications.student_id = students.id )
                           AS application_count
FROM      students
ORDER BY  application_count DESC,
          students.name
````

### 2. "Shapely"

Find this in `lib/spatterbox/shapely.rb`

#### Important note

The provided sample output had seemingly arbitrary decimal places
(perimter of 10.5 and area of 5.30 for triangle for example). I just
went ahead and showed exactly two decimals places for everything.

To run on the sample data:

`ruby bin/shapely.rb sample`

Or use your own file:

`ruby bin/shapely.rb /Users/brentvatne/docs/sample_shapes.csv`

(replace this path with a full path to your file)

### 3. "Tag Prettifier"

Find this in `lib/spatterbox/tag_prettifier.rb`

There are (at least) two ways to run this from your command line:

#### Unix pipe syntax

````
cat /Users/brentvatne/docs/sample_tags.txt | ruby bin/prettify.rb
````

(replace this path with a full path to your file)

#### Manually feeding in input

Or just:

`ruby bin/prettify.rb`

And enter your data as you please into the command line.

### 4. "Recursively Tag"

Find this in `lib/spatterbox/recursively_tag.rb`

You might notice when you look at the source that it's about 5 LOC. That
is because I lean heavily on the XMLTag class that is used in the "Tag
Prettifier" as well.

Run it with

`ruby bin/recursively_tag.rb`

This will run over the sample data, a b c d e f. If you want to change
that, just open up `bin/recursively_tag.rb` and put in whatever you
like.
