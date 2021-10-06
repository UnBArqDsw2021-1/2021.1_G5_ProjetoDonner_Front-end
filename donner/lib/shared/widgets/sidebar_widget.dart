import 'package:donner/shared/themes/app_colors.dart';
import 'package:donner/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SidebarWidget extends StatefulWidget {
  const SidebarWidget({ Key? key }) : super(key: key);

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
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.zero,
                      child: ListTile(
                        onTap: (){},
                        leading: const Icon(
                          FontAwesomeIcons.solidUserCircle,
                          color: AppColors.primary,
                          size: 50
                        ),
                        title: Text("Acesse sua conta",style: AppTextStyles.bodyTextBlack,),
                        subtitle: Text("Clique aqui", style: AppTextStyles.bodyTextSmall,),
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                    color: AppColors.stroke,
                  ),
                  ListTile(
                    onTap: () {},
                    leading: const Icon(
                      FontAwesomeIcons.plusSquare,
                      color: AppColors.secondary,
                      size: 30,
                    ),
                    title: Text(
                      "Criar anúncio",
                      style: AppTextStyles.cardText,
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: const ImageIcon(
                      AssetImage('assets/mini_logo_donner.png'),
                      color: AppColors.primary,
                      size: 30,
                    ),
                    title: Text(
                      "Doações e pedidos",
                      style: AppTextStyles.cardText,
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: const Icon(
                      FontAwesomeIcons.user,
                      color: AppColors.secondary,
                      size: 30,
                    ),
                    title: Text(
                      "Meu Perfil",
                      style: AppTextStyles.cardText,
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {},
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