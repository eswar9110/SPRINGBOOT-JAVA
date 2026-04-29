package com.bookauthor.app.model;

import javax.persistence.*;
import javax.validation.constraints.*;

/**
 * Entity class representing a Book.
 * Each Book belongs to one Author (Many-to-One relationship).
 */
@Entity
@Table(name = "books")
public class Book {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message = "Title is required")
    @Size(min = 1, max = 200, message = "Title must be between 1 and 200 characters")
    @Column(nullable = false)
    private String title;

    @NotBlank(message = "ISBN is required")
    @Column(nullable = false, unique = true)
    private String isbn;

    @NotNull(message = "Price is required")
    @DecimalMin(value = "0.0", message = "Price must be a positive value")
    @Column(nullable = false)
    private Double price;

    @Min(value = 1000, message = "Year must be a valid 4-digit year")
    @Max(value = 2030, message = "Year must be a valid 4-digit year")
    @Column(name = "year_published")
    private Integer yearPublished;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "author_id", nullable = false)
    private Author author;

    // Default constructor
    public Book() {
    }

    // Parameterized constructor
    public Book(String title, String isbn, Double price, Integer yearPublished, Author author) {
        this.title = title;
        this.isbn = isbn;
        this.price = price;
        this.yearPublished = yearPublished;
        this.author = author;
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getIsbn() {
        return isbn;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Integer getYearPublished() {
        return yearPublished;
    }

    public void setYearPublished(Integer yearPublished) {
        this.yearPublished = yearPublished;
    }

    public Author getAuthor() {
        return author;
    }

    public void setAuthor(Author author) {
        this.author = author;
    }

    @Override
    public String toString() {
        return "Book{id=" + id + ", title='" + title + "', isbn='" + isbn + "'}";
    }
}
