import 'package:flutter/material.dart';
import 'package:elsie/widgets/widgets.dart';

class BodyDetailInfo {
  late String title;
  late String description;
  late bool showInColumn;

  BodyDetailInfo({ 
    required this.title, 
    required this.description, 
    this.showInColumn = false
  });
}

class TimeCardData {
  late String title;
  late List<String> tags;
  late List<BodyDetailInfo> bodyData;
  late String? actionText;
  late Function? onAction;
  late Function? onTap;

  TimeCardData({
    required this.title,
    this.tags = const[],
    this.bodyData = const [],
    this.actionText,
    this.onAction,
    this.onTap
  });
}

class TimeCard extends StatefulWidget {
  const TimeCard({ super.key, required this.data });

  final List<TimeCardData> data;

  @override
  State<TimeCard> createState() => _TimeCardState();
}

class _TimeCardState extends State<TimeCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(18, 0, 18, 0),
      padding: const EdgeInsets.fromLTRB(9, 9, 9, 9),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, .12),
            blurRadius: 12,
            offset: Offset(0, 6)
          ),
        ],
      ),
      child: Column(
        children: widget.data.map((item) {
          return Container(
            padding: const EdgeInsets.fromLTRB(0, 7, 0, 7),
            child: Card( //*Time container
              elevation: 0,
              child: Container(
                child: Theme( //*Collapse Card
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    initiallyExpanded: true,
                    tilePadding: const EdgeInsets.fromLTRB(9, 3, 9, 3),
                    childrenPadding: const EdgeInsets.fromLTRB(15, 9, 15, 0),
                    title: const Text(""),
                    leading: Column( //*Head data
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: const TextStyle(
                            color: Color.fromRGBO(0, 165, 156, 1),
                            fontSize: 15,
                            fontWeight: FontWeight.w500
                          )
                        ),
                        if(item.tags.isNotEmpty) Container(
                          margin: const EdgeInsets.only(top: 9),
                          width: 300,
                          child: Row(
                            children: [
                              ...item.tags.map((tag) {
                                return Container(
                                  margin: const EdgeInsets.only(right: 12),
                                  child: BadgeCard(tag),
                                );
                              }).toList(),
                            ],
                          ),
                        )
                      ],
                    ),
                    trailing: const Text(""),
                    children: [
                      ...item.bodyData.map((info) { //*BODY DETAIL DATA
                        if(info.showInColumn) {
                          return Container();
                        }

                        return Container(
                          margin: const EdgeInsets.only(top: 12),
                          child: Row(
                            children: [
                              Expanded( //*Title
                                flex: 1,
                                child: Text(
                                  info.title,
                                  style: const TextStyle(
                                    color: Color.fromRGBO(41, 41, 41, 1),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500
                                  )
                                ),
                              ),
                              Container( //*Time
                                child: Text(
                                  info.description,
                                  style: const TextStyle(
                                    color: Color.fromRGBO(81, 81, 81, 1),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500
                                  )
                                ),
                              ),
                            ],
                          )
                        );
                      }).toList(), 

                      Container( //*BODY COLUMN DATA
                        margin: const EdgeInsets.only(top: 12),
                        child: Row(
                          children: item.bodyData.map((info) {
                            if(!info.showInColumn) return Container();
                            
                            return Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container( //*Title
                                    child: Text(
                                      info.title,
                                      style: const TextStyle(
                                        color: Color.fromRGBO(41, 41, 41, 1),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500
                                      )
                                    ),
                                  ),
                                  Container( //*Time
                                    margin: const EdgeInsets.only(top: 9),
                                    child: Text(
                                      info.description,
                                      style: const TextStyle(
                                        color: Color.fromRGBO(81, 81, 81, 1),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500
                                      )
                                    ),
                                  ),
                                ],
                              ),
                            );
                        }).toList())
                      ),

                      if(item.onAction != null && item.actionText != null) Container( //*ACTIONS
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 15),
                        child: Button(
                          onPressed: item.onAction!,
                          text: item.actionText!
                        ),
                      ),

                      if(item.bodyData.length > 1) Container(
                        margin: const EdgeInsets.only(top: 21),
                        height: 1,
                        color: Colors.black.withOpacity(.15),
                      )
                    ]
                  ),
                )
                // Column(
                //   children: [
                //     Container( //*HEAD
                //       child: Row(
                //         children: [
                //           Expanded( //*Title
                //             flex: 1,
                //             child: Text(
                //               item.title,
                //               style: const TextStyle(
                //                 color: Color.fromRGBO(0, 165, 156, 1),
                //                 fontSize: 15,
                //                 fontWeight: FontWeight.w500
                //               )
                //             ),
                //           ),
                //           if(item.time != null) Container( //*Time
                //             child: BadgeCard(item.time!),
                //           ),
                //         ],
                //       ),
                //     ),
                //     Column(//*BODY INFORMATION DATA
                //       children: item.bodyData.map((info) {
                //         return Container(
                //           margin: const EdgeInsets.only(top: 12),
                //           child: Row(
                //             children: [
                //               Expanded( //*Title
                //                 flex: 1,
                //                 child: Text(
                //                   info.title,
                //                   style: const TextStyle(
                //                     color: Color.fromRGBO(41, 41, 41, 1),
                //                     fontSize: 14,
                //                     fontWeight: FontWeight.w500
                //                   )
                //                 ),
                //               ),
                //               Container( //*Time
                //                 child: Text(
                //                   info.description,
                //                   style: const TextStyle(
                //                     color: Color.fromRGBO(81, 81, 81, 1),
                //                     fontSize: 14,
                //                     fontWeight: FontWeight.w500
                //                   )
                //                 ),
                //               ),
                //             ],
                //           )
                //         );
                //       }).toList()
                //     ),
                //     if(item.onAction != null && item.actionText != null) Container( //*ACTIONS
                //       margin: const EdgeInsets.only(top: 15),
                //       child: Button(
                //         onPressed: item.onAction!,
                //         text: item.actionText!
                //       ),
                //     )
                //   ],
                // ),
              ),
            ),
          );
        }).toList()
      )
    );
  }
}