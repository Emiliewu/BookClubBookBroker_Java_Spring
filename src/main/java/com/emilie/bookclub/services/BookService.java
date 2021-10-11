package com.emilie.bookclub.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.emilie.bookclub.models.Book;
import com.emilie.bookclub.models.User;
import com.emilie.bookclub.repositories.BookRepository;
import com.emilie.bookclub.repositories.UserRepository;

@Service
public class BookService {
	
	@Autowired
	private UserRepository userRepo;
	
	@Autowired
	private BookRepository bookRepo;
	
	//find all books
	public List<Book> findAllBooks() {
		return bookRepo.findAll();
	}
	
	//find book by id
	public Book findBookById(Long id) {
		Optional<Book> b = bookRepo.findById(id);
		if(b.isPresent()) {
			return b.get();
		} else {
			return null;
		}
	}
	
	//create
	public Book createNewBook(Book b) {
		return bookRepo.save(b);
	}
	
	// update
	public Book updateBook(Book b) {
		return bookRepo.save(b);
	} 
	
	// delete
	public void deleteBook(Long id) {
		bookRepo.deleteById(id);
	}
	
	//borrow book
	public void borrowBook(Long userId, Long bookId) {
		Book b = bookRepo.findById(bookId).orElse(null);
		User u = userRepo.findById(userId).orElse(null);
		b.setBorrower(u);
		bookRepo.save(b);
	}
	
	//return book
	public void returnBook(Long userId, Long bookId) {
		Book b = bookRepo.findById(bookId).orElse(null);
		User u = userRepo.findById(userId).orElse(null);	
		b.setBorrower(null);
		bookRepo.save(b);		
	}

}
