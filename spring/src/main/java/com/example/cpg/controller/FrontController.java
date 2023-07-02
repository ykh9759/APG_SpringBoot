package com.example.cpg.controller;

import org.springframework.stereotype.Controller;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import com.example.cpg.domain.ChatVo;


@Controller
public class FrontController {

    // /receive를 메시지를 받을 endpoint로 설정
    @MessageMapping("/receive")
    // /send로 메시지를 반환합니다.
    @SendTo("/send")
    // SocketHandler는 1) /receive에서 메시지를 받고, /send로 메시지를 보내준다
    public ChatVo SocketHandler(ChatVo socketVO) {

        String userName = socketVO.getUserName();
        String content = socketVO.getContent();

        // 생성자로 반환값을 생성합니다.
        ChatVo result = ChatVo.builder()
                            .userName(userName)
                            .content(content)
                            .build();
        // 반환
        return result;
    }
}