package com.bookauthor.app.dto;

/**
 * Data Transfer Object for the inner join query result
 * between Book and Author entities.
 */
public class BookAuthorDTO {

    private String bookTitle;
    private String isbn;
    private Double price;
    private Integer yearPublished;
    private String authorName;
    private String authorEmail;

    // Constructor used by JPQL NEW expression
    public BookAuthorDTO(String bookTitle, String isbn, Double price,
                         Integer yearPublished, String authorName, String authorEmail) {
        this.bookTitle = bookTitle;
        this.isbn = isbn;
        this.price = price;
        this.yearPublished = yearPublished;
        this.authorName = authorName;
        this.authorEmail = authorEmail;
    }

    // Default constructor
    public BookAuthorDTO() {
    }

    // Getters and Setters
    public String getBookTitle() {
        return bookTitle;
    }

    public void setBookTitle(String bookTitle) {
        this.bookTitle = bookTitle;
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

    public String getAuthorName() {
        return authorName;
    }

    public void setAuthorName(String authorName) {
        this.authorName = authorName;
    }

    public String getAuthorEmail() {
        return authorEmail;
    }

    public void setAuthorEmail(String authorEmail) {
        this.authorEmail = authorEmail;
    }
}
