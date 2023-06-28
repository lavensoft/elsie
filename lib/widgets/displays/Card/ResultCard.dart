import "dart:convert";

import "package:flutter/material.dart";
import "package:elsie/widgets/widgets.dart";
import "package:elsie/api/ElsieAction.dart";
import 'package:url_launcher/url_launcher.dart';

class ResultCard extends StatefulWidget {
  const ResultCard({ super.key, required this.elsieAction, required this.data });

  final String elsieAction;
  final List<dynamic> data;

  @override
  State<ResultCard> createState() => _ResultCardState();
}

class _ResultCardState extends State<ResultCard> {
  @override
  Widget build(BuildContext context) {
    switch(widget.elsieAction) {
      case ElsieAction.GET_MYAP_SCHEDULE: //*LỊCH HỌC
        return TimeCard(
          data: widget.data.map((item) {
            return TimeCardData(
              title: item["subject"], 
              tags: [item["date"]],
              bodyData: [
                BodyDetailInfo(
                  title: "Mã môn:", 
                  description: item["subject_code"]),
                BodyDetailInfo(
                  title: "Lớp:", 
                  description: item["classroom"]),
                BodyDetailInfo(
                  title: "Ca:", 
                  description: item["session"]),
                BodyDetailInfo(
                  title: "Phòng:", 
                  description: item["room"]),
                BodyDetailInfo(
                  title: "Giảng viên:", 
                  description: item["teacher"]),
                BodyDetailInfo(
                  title: "Giảng đường:", 
                  description: item["school"]),
              ],
              actionText: item["link"] != "" ? "Tham gia Meet" : null,
              onAction: () async {
                if(item["link"] != "") {
                  await launch(item["link"]);
                }
              }
            );
          }).toList()
        );
      case ElsieAction.GET_MYAP_SUBJECT_CHECKIN: //*ĐIỂM DANH
        return TimeCard(
          data: widget.data.map((item) {
            return TimeCardData(
              title: item["subject"], 
              tags: [
                item["absent_by_total_checkin"],
                item["absent_by_total"]
              ],
              bodyData: [
                // BodyDetailInfo("Môn học:", item["subject"]),
                BodyDetailInfo(
                  title: "Số buổi vắng:", 
                  description: item["absent"],
                  showInColumn: true
                ),
                BodyDetailInfo(
                  title: "Số buổi có mặt:", 
                  description: item["checkin"],
                  showInColumn: true
                ),
                BodyDetailInfo(
                  title: "Số buổi vắng trên tổng số buổi điểm danh:", 
                  description: item["absent_by_total_checkin"]
                ),
                BodyDetailInfo(
                  title: "Số buổi vắng trên tổng số buổi học:", 
                  description: item["absent_by_total"]
                ),
              ]
            );
          }).toList()
        );
      case ElsieAction.GET_LMS_HOMEWORK: //*CÁC BÀI TẬP TRÊN LMS
        return TimeCard(
          data: widget.data.map((item) {
            return TimeCardData(
              title: item["course"], 
              tags: ["${item["date"]} ${item["time"]}"],
              bodyData: [
                BodyDetailInfo(
                  title: "Bài tập:", 
                  description: item["lab_name"]),
                BodyDetailInfo(
                  title: "Thời hạn:", 
                  description: "${item["date"]} ${item["time"]}",),
              ],
              actionText: item["handin_link"] != "" ? "Nộp bài" : null,
              onAction: () async {
                if(item["handin_link"] != "") {
                  await launch(item["handin_link"]);
                }
              }
            );
          }).toList()
        );
      case ElsieAction.GET_LMS_COURSE: //*LỚP ĐANG THAM GIA
        return TimeCard(
          data: widget.data.map((item) {
            List<BodyDetailInfo> bodyData = [];

            item["classrooms"].forEach((classroom) {
              bodyData.add(
                BodyDetailInfo(
                  title: classroom["name"],
                  description: ""
                )
              );
            });

            return TimeCardData(
              title: item["courses"], 
              bodyData: bodyData
            );
          }).toList()
        );
      case ElsieAction.GET_NEWS_ARTICLES: //*TIN TỨC
        return Column(
          children: widget.data.map((item) {
            return ImageCard(
              title: item["title"],
              image: item["thumbnail"],
              href: item["link"],
              tags: item["tags"] != null ? item["tags"].split(",") : []
            );
          }).toList()
        );
      case ElsieAction.GET_MYAP_EVENT: //*SỰ KIỆN TẠI TRƯỜNG
        return Column(
          children: widget.data.map((item) {
            return ImageCard(
              title: item["title"],
              image: item["thumbnail"],
              href: item["link"],
              tags: item["tags"] != null ? item["tags"].split(",") : []
            );
          }).toList()
        );
      case ElsieAction.GET_CODE: //*CODE
        return CodeView(code: widget.data[0]);
      case ElsieAction.GET_JAVA_EXPLAIN: //*JAVA EXPLAIN LIEN KET RANG BUOC
        return ImageCard(
          title: widget.data[0]["title"],
          image: widget.data[0]["thumbnail"],
          href: widget.data[0]["link"]
        );
      case ElsieAction.GET_TODAY_SCHEDULE: //*CODE
        return TimeCard(
          data: widget.data.map((item) {
            return TimeCardData(
              title: item["lab_name"] ?? item["subject"], 
              tags: ["${item["time"]}"],
              bodyData: [
                if(item["lab_name"] != null) BodyDetailInfo(
                  title: "Bài tập:", 
                  description: item["lab_name"]),
                if(item["lab_name"] != null) BodyDetailInfo(
                  title: "Thời hạn:", 
                  description: "${item["date"]} ${item["time"]}",),
                if(item["subject_code"] != null) BodyDetailInfo(
                  title: "Mã môn:", 
                  description: item["subject_code"]),
                if(item["classroom"] != null) BodyDetailInfo(
                  title: "Lớp:", 
                  description: item["classroom"]),
                if(item["session"] != null) BodyDetailInfo(
                  title: "Ca:", 
                  description: item["session"]),
                if(item["room"] != null) BodyDetailInfo(
                  title: "Phòng:", 
                  description: item["room"]),
                if(item["teacher"] != null) BodyDetailInfo(
                  title: "Giảng viên:", 
                  description: item["teacher"]),
                if(item["school"] != null) BodyDetailInfo(
                  title: "Giảng đường:", 
                  description: item["school"]),
              ],
              actionText: item["handin_link"] != "" ? "Nộp bài" : null,
              onAction: () async {
                if(item["handin_link"] != "") {
                  await launch(item["handin_link"]);
                }
              }
            );
          }).toList()
        );
      case ElsieAction.GET_THANKS: //*THANKS
        return const ImageCard(
          title: "Tym 🫶",
          image: "https://i.imgur.com/ciHoGEP.jpeg"
        );
      case ElsieAction.GET_CHECKIN_EVENT: //*THANKS
        return Container();
      default:
        return Container();
    }
  }
}