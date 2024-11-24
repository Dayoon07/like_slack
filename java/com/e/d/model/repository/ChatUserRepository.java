package com.e.d.model.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.e.d.model.entity.ChatUserEntity;

@Repository
public interface ChatUserRepository extends JpaRepository<ChatUserEntity, Integer>{
	Optional<ChatUserEntity> findByUsernameAndUserpassword(String username, String userpassword);
	Optional<ChatUserEntity> findByUsername(String username);
}