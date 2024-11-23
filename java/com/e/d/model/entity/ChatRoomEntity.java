package com.e.d.model.entity;

import java.time.LocalDateTime;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;

@Entity
@Table(name = "CHATROOM")
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ChatRoomEntity {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "roomid")
    private int roomid;

    @Column(name = "roomname", nullable = false)
    private String roomname;

    @Column(name = "roomnameinname", nullable = false)
    private String roomnameinname;

    @CreationTimestamp
    @Column(name = "date_time", nullable = false, updatable = false)
    private LocalDateTime dateTime;

    @Column(name = "ownername", nullable = false)
    private String ownername;
}
