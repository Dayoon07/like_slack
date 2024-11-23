	package com.e.d.model.entity;

import java.time.LocalDateTime;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "CHATUSER")
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ChatUserEntity {
    
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "userid", nullable = false)
    private int userid;

    @Column(name = "username", nullable = false, unique = true)
    private String username;

    @Column(name = "useremail", nullable = false)
    private String useremail;

    @Column(name = "userpassword", nullable = false)
    private String userpassword;

    @Lob
    @Column(name = "userbio", nullable = false)
    private String userbio;

    @Column(name = "date_time", columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP", nullable = false)
    private LocalDateTime dateTime;

    @Column(name = "status", columnDefinition = "VARCHAR2(255 CHAR) DEFAULT 'offline'", nullable = false)
    private String status;
    
}
