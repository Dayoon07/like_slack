package com.e.d.model.entity;

import java.time.LocalDateTime;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "CHAT_MESSAGE")
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ChatMessageEntity {
	
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "message_id")
    private int messageId;

    @Column(name = "roomid")
    private int roomid;

    @Column(name = "userid")
    private int userid;

    @Lob
    @Column(name = "chattext", nullable = false)
    private String chattext;

    @Column(name = "date_time", columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP")
    private LocalDateTime dateTime;
    
    @Column(name = "username", nullable = false)
    private String username;
    
    @Column(name = "type")
    private String type;

    @Column(name = "data")
    private String data;
    
    @Column(name = "receiver")
    private String receiver;
    
    @Column(name = "sender")
    private String sender;
	
}
