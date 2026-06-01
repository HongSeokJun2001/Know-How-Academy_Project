package com.kh.know_how.reservation.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.know_how.reservation.model.service.ReservationService;
import com.kh.know_how.reservation.model.vo.Reservation;

@Controller
@RequestMapping("reservation")
public class ReservationController {

    @Autowired
    private ReservationService reservationService;

    @GetMapping("/list")
    public String selectReservationList(Model model) {

        ArrayList<Reservation> list
            = reservationService.selectReservationList();

        model.addAttribute("list", list);

        return "reservation/reservationListview";
    }
}