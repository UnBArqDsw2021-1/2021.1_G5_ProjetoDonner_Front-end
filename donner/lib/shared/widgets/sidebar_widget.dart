import 'package:donner/controllers/authentication.dart';
import 'package:donner/models/client_model.dart';
import 'package:donner/shared/services/firestore_service.dart';
import 'package:donner/shared/themes/app_colors.dart';
import 'package:donner/shared/themes/app_text_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SidebarWidget extends StatefulWidget {
  final ClientModel? user;
  const SidebarWidget({Key? key, this.user}) : super(key: key);

  @override
  _SidebarWidgetState createState() => _SidebarWidgetState();
}

class _SidebarWidgetState extends State<SidebarWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                SizedBox(
                  height: 80,
                  child: DrawerHeader(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.zero,
                    child: ListTile(
                      onTap: () {
                        if (widget.user != null) {
                          Navigator.pushNamed(context, '/profile',
                              arguments: widget.user);
                        } else {
                          Navigator.pushReplacementNamed(
                            context,
                            '/login',
                          );
                        }
                      },
                      leading: widget.user == null
                          ? const Icon(
                              FontAwesomeIcons.solidUserCircle,
                              color: AppColors.primary,
                              size: 50,
                            )
                          : Container(
                              width: 50.0,
                              height: 50.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(widget.user!.photoUrl!)
                                ),
                              ),
                            ),
                      title: widget.user != null
                          ? Text(
                              widget.user!.name,
                              style: AppTextStyles.bodyTextSmall,
                            )
                          : Text(
                              "Acesse sua conta",
                              style: AppTextStyles.bodyTextBlack,
                            ),
                      subtitle: widget.user != null
                          ? Text(
                              "${widget.user!.city}-${widget.user!.state}\n${widget.user!.email}",
                              style: AppTextStyles.bodyTextSmall,
                            )
                          : Text(
                              "Clique aqui",
                              style: AppTextStyles.linkTextSmall,
                            ),
                    ),
                  ),
                ),
                const Divider(
                  thickness: 1,
                  color: AppColors.stroke,
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, "/create_post");
                  },
                  leading: Icon(
                    FontAwesomeIcons.plusSquare,
                    color: widget.user == null ? Colors.grey : AppColors.secondary,
                    size: 30,
                  ),
                  title: Text(
                    "Criar anúncio",
                    style: widget.user == null ? const TextStyle(color: Colors.grey) : AppTextStyles.cardText,
                  ),
                  enabled: widget.user == null ? false : true,
                ),
                ListTile(
                  onTap: () {},
                  leading: ImageIcon(
                    const AssetImage('assets/mini_logo_donner.png'),
                    color: widget.user == null ? Colors.grey : AppColors.primary,
                    size: 30,
                  ),
                  title: Text(
                    "Doações e pedidos",
                    style: widget.user == null ? const TextStyle(color: Colors.grey) : AppTextStyles.cardText,
                  ),
                  enabled: widget.user == null ? false : true,
                ),
                ListTile(
                  onTap: () async {
                    if (widget.user != null) {
                      await Navigator.pushNamed(context, '/profile',
                          arguments: widget.user);
                    } else {
                      await Navigator.pushReplacementNamed(context, '/login');
                    }
                  },
                  leading: const Icon(
                    FontAwesomeIcons.user,
                    color: AppColors.secondary,
                    size: 30,
                  ),
                  title: Text(
                    'Meu Perfil',
                    style: AppTextStyles.cardText,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: () async {
                await Authentication().signOut(context);

                // setState(() {});
                // Navigator.pushReplacementNamed(context, '/home');
              },
              child: ListTile(
                leading: const Icon(
                  Icons.logout,
                  color: AppColors.primary,
                ),
                title: Text(
                  "Fazer logout",
                  style: AppTextStyles.bodyText,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
