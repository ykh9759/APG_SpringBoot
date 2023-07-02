package com.example.cpg.domain;

import lombok.Data;
import lombok.Builder;

@Data
public class ChatVo {
    // 유저의 이름을 저장하기 위한 변수
    private String userName;

    // 메시지의 내용을 저장하기 위한 변수
    private String content;

    @Builder
    public ChatVo(String userName, String content ) {
        this.userName = userName;
        this.content = content;
    }
    
}
