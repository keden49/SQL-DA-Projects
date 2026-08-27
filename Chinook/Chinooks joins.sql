-- Chinook is reviewing its catalogue and sales data to understand relationships between tracks, albums, artists, invoices, and media types.
-- Your task is to analyze how these entities connect — identifying which albums have title tracks, which tracks have never been purchased, and exploring potential product category combinations for future marketing initiatives.

USE chinook;

SHOW TABLES;


-- Sometimes artists add a title track to their albums, meaning a track that has the same title as the album. 
-- Write a query that returns albums that have a title track.
-- Return: AlbumId from Album, Title from Album, Name from Track. Match rows where Album.Title = Track.Name.


-- view album

SELECT *
FROM album
LIMIT 5;


SELECT a.AlbumId, a.Title,t.Name
FROM album a
JOIN track t ON a.Title = t.Name;


-- Using your result from Exercise 1, extend the query to include the artist of each album.

-- Return: AlbumId from Album, Title from Album, Name from Track, Name from Artist. Match on Album.Title = Track.Name and Artist.ArtistId = Album.ArtistId.

SELECT a.AlbumId, a.Title,t.Name, artist.Name
FROM album a
JOIN track t ON a.Title = t.Name
JOIN artist ON a.ArtistId = artist.ArtistId;


-- A useful case for LEFT JOIN is checking for missing related records. Write a query that lists all tracks and shows whether they appear in any invoice line (indicating a purchase).

-- Return: TrackId from Track, InvoiceId from InvoiceLine (if it exists). Use a LEFT JOIN from Track to InvoiceLine on TrackId.

SELECT t.TrackId, InvoiceId
FROM track t
LEFT JOIN invoiceline i ON t.TrackId = i.TrackId;


-- Using the query from Exercise 3, filter the results to show only tracks that have not been purchased. 
-- Only include rows where InvoiceLine.InvoiceId IS NULL.

SELECT t.TrackId, InvoiceId
FROM track t
LEFT JOIN invoiceline i ON t.TrackId = i.TrackId
WHERE InvoiceId IS NULL;


-- Chinook wants to define potential product categories based on genre and media type.
-- Write a query that lists all possible combinations of Genre.Name and MediaType.Name. Use a CROSS JOIN.

SELECT g.Name,m.Name
FROM genre g
CROSS JOIN mediatype m;








