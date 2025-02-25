import 'package:flutter/material.dart';

class MediacalCardWidget extends StatelessWidget {
  final String displayName;
  final String phoneNumber;
  final String imagePath;
  final VoidCallback onTap;

  const MediacalCardWidget({
    required this.displayName,
    required this.phoneNumber,
    required this.imagePath,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(120, 120, 120, 0.24),
                offset: Offset(0, 0),
                blurRadius: 13,
                spreadRadius: 0,
              ),
            ],
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(children: [
            Container(
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
              ),
              child: imagePath != ''
                ? ClipOval(
                    child: Image.network(
                      imagePath,
                      fit: BoxFit.cover,
                      width: 52,  
                      height: 52,  
                    ),
                  )
                : Icon(Icons.person),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      overflow: TextOverflow.ellipsis,
                      displayName,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff3384E2),
                          fontFamily: 'Montserrat'),
                    ),
                    Text(
                      phoneNumber,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff2C3E4F),
                          fontFamily: 'Montserrat'),
                    ),
                  ],
                ),
              ),
            ),
            Image.asset('assets/images/arrow_rigth.png')
          ]),
        ),
      ),
    );
  }
}
