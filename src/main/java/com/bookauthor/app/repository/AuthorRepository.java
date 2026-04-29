package com.bookauthor.app.repository;

import com.bookauthor.app.model.Author;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 * Repository interface for Author entity.
 * Provides standard CRUD operations via JpaRepository.
 */
@Repository
public interface AuthorRepository extends JpaRepository<Author, Long> {

    /**
     * Find an author by email address.
     * @param email the email to search for
     * @return the Author with the given email, or null if not found
     */
    Author findByEmail(String email);
}
