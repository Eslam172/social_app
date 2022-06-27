import 'package:flutter/material.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 10,
            child: Image(
              image: AssetImage('assets/images/social_2.jpg'),
              width: double.infinity,
              height: 210,
              fit: BoxFit.cover,
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => buildPostItem(context),
            itemCount: 10,
          ),
          const SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }

  Widget buildPostItem(context) => Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                      'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?t=st=1656269226~exp=1656269826~hmac=c2cac1fd6bc1bdc003e7553f537cc89b0d3130c58bcfaf4d30da7abaee7870b5&w=996'),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Text('Eslam Elfnan'),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.check_circle,
                          size: 15,
                          color: Colors.indigo,
                        )
                      ],
                    ),
                    Text(
                      'january 21, 2022 at 7:00 pm',
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(fontSize: 12),
                    ),
                  ],
                )),
                const SizedBox(
                  width: 15,
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_horiz_outlined,
                      size: 18,
                    ))
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 15,
              ),
              width: double.infinity,
              color: Colors.grey,
              height: 0.3,
            ),
            Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged'),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 5),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                children: [
                  Container(
                    height: 25,
                    margin: EdgeInsetsDirectional.only(end: 10),
                    child: MaterialButton(
                      padding: EdgeInsets.zero,
                      height: 25,
                      textColor: Colors.blue,
                      minWidth: 1,
                      onPressed: () {},
                      child: Text(
                        '#software',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: Colors.blue),
                      ),
                    ),
                  ),
                  Container(
                    height: 25,
                    // margin: EdgeInsetsDirectional.only(end: 20),
                    child: MaterialButton(
                      padding: EdgeInsets.zero,
                      height: 25,
                      textColor: Colors.blue,
                      minWidth: 1,
                      onPressed: () {},
                      child: Text(
                        '#flutter_develpment',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: Colors.blue),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                image: const DecorationImage(
                    image: AssetImage('assets/images/social.jpg'),
                    fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Row(
                        children: [
                          Icon(
                            IconBroken.Heart,
                            color: Colors.red,
                            size: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '120',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(fontSize: 14),
                          )
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            IconBroken.Chat,
                            color: Colors.amber,
                            size: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '20 comments',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(fontSize: 14),
                          )
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 0.3,
              color: Colors.grey,
              margin: EdgeInsetsDirectional.only(bottom: 10),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundImage: NetworkImage(
                              'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?t=st=1656269226~exp=1656269826~hmac=c2cac1fd6bc1bdc003e7553f537cc89b0d3130c58bcfaf4d30da7abaee7870b5&w=996'),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'write a comment ...',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                ),
                InkWell(
                  child: Row(
                    children: [
                      const Icon(
                        IconBroken.Heart,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'love',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(fontSize: 14),
                      )
                    ],
                  ),
                  onTap: () {},
                )
              ],
            ),
          ],
        ),
      ));
}
