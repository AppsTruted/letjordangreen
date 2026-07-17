import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:letjordangreen/core/hive/user.dart';
import 'package:letjordangreen/core/router/routes_names.dart';
import 'package:letjordangreen/core/utils/constants/app_colors.dart';
import 'package:letjordangreen/features/feature_user_information/cubits/user_information_cubit/user_information_cubit.dart';
import 'package:letjordangreen/features/feature_user_information/cubits/user_information_cubit/user_information_state.dart';
import 'package:letjordangreen/widgets/url_launcher.dart';


class DrawerView extends StatefulWidget {
  const DrawerView({super.key});

  static const Color bg = Color(0xfffdf6ed);
  static const Color darkGreen = Color(0xff00451f);
  static const Color cardGreen = Color(0xff074d26);
  static const Color softGreen = Color(0xffeaffef);
  static const Color textDark = Color(0xff202018);
  static const Color muted = Color(0xff575a53);
  static const Color cream = Color(0xfff5ecd8);
  static const Color danger = Color(0xffe92525);

  @override
  State<DrawerView> createState() => _DrawerViewState();
}

class _DrawerViewState extends State<DrawerView> {
  UserInformationCubit userInformationCubit = UserInformationCubit();
  late UserHiveModel userHiveModel;

  @override
  void initState() {
    super.initState();
    userHiveModel = userInformationCubit.state.userHiveModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DrawerView.bg,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 34),
            child: BlocBuilder<UserInformationCubit, UserInformationState>(
            builder: (context, state) {
              return Column(
              children: [

                _buildHeader(),

                // const SizedBox(height: 20),

                // Text(
                //   "Dedicated to restoring Jordan's green canopy through precise, sustainable impact.",
                //   textAlign: TextAlign.center,
                //   style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
                // ),

                const SizedBox(height: 22),

                 Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "ACCOUNT MANAGEMENT",
                    style: Theme.of(context).textTheme.bodyLarge,

                  ),
                ),

                const SizedBox(height: 18),

                if(state.isLoggedIn)
                _ManagementTile(
                  icon: Icons.person_2,
                  title: "Edit Profile",
                  subtitle: "Personal Info, Email, Password",
                  onTap: () {
                    context.push(AppRoutes.editProfileScreen);
                  },
                ),
                if(state.isLoggedIn && (userHiveModel.roles!.contains("inspector") || userHiveModel.roles!.contains("superAdmin")))
                const SizedBox(height: 18),

                if(state.isLoggedIn && (userHiveModel.roles!.contains("inspector") || userHiveModel.roles!.contains("superAdmin")))
                  _ManagementTile(
                    icon: Icons.search,
                    title: "Inspection Queue",
                    subtitle: "Field Inspection Ledger",
                    onTap: () {
                      context.push(AppRoutes.inspectionQueueScreen);
                    },
                  ),
                if(state.isLoggedIn && (userHiveModel.roles!.contains("farmer")))
                const SizedBox(height: 16),
                if(state.isLoggedIn && (userHiveModel.roles!.contains("farmer")))

                _ManagementTile(
                  icon: Icons.search,
                  title: "Supply orders",
                  subtitle: "See my own supply orders",
                  onTap: () {
                    context.push(AppRoutes.farmerSupplyOrders);
                  },
                ),
                const SizedBox(height: 16),

                _ManagementTile(
                  icon: Icons.public_rounded,
                  title: "Impact",
                  subtitle: "Measuring What Matters",
                  onTap: () {
                    launchUrlCustom("https://let-jordan.apple-jo.com/impact");
                  },
                ),

                const SizedBox(height: 16),

                _ManagementTile(
                  icon: Icons.info,
                  title: "About Us",
                  subtitle: "Restoring Life to the Soil",
                  onTap: () {
                    launchUrlCustom("https://let-jordan.apple-jo.com/about");
                  },
                ),

                const SizedBox(height: 16),

                _ManagementTile(
                  icon: Icons.shield,
                  title: "Security & Privacy",
                  subtitle: "Two-factor, Data usage",
                  onTap: () {},
                ),

                const SizedBox(height: 16),

                if(!state.isLoggedIn)
                _ManagementTile(
                  icon: Icons.login,
                  title: "Login",
                  subtitle: "Login to get more features",
                  onTap: () {
                    context.push(AppRoutes.loginWithEmail);
                  },
                ),

                const SizedBox(height: 28),

                if(state.isLoggedIn)
                _LogoutTile(
                  onTap: ()=> logOut(context),
                ),
                const SizedBox(height: 40),

                Text(
                  "Let jordan green v1.0.0 • Eco Guardian Protocol",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.25),
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 28),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 4,
                  children: [
                    Text("Developed by ", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.primaryColor.withOpacity(.6))),
                    InkWell(
                      onTap: (){
                        launchUrlCustom("https://truted.com/");
                      },
                      child: Text("TRUTED"),
                    )
                  ],
                ),
                const SizedBox(height: 20),


              ],
            );
  },
),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        const BackButton(),
         Expanded(
          child: Center(
            child: Text(
              "Let jordan green".toUpperCase(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
        InkWell(
          onTap: (){
            launchUrlCustom("https://let-jordan.apple-jo.com/contact");
          },
          child: ClipOval(
            child: Image.asset(
              "assets/images/profile_avatar.jpg",
              width: 43,
              height: 43,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) {
                return Container(
                  width: 43,
                  height: 43,
                  color: DrawerView.softGreen,
                  child: const Icon(
                    Icons.support_agent_outlined,
                    color: DrawerView.darkGreen,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
  logOut(BuildContext context) {
    context.read<UserInformationCubit>().logout(context);
    context.go(AppRoutes.loginWithEmail);
  }
}

class _ManagementTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String? badge;
  final VoidCallback onTap;

  const _ManagementTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.badge,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: DrawerView.softGreen,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: DrawerView.darkGreen,
                  size: 26,
                ),
              ),

              const SizedBox(width: 20),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),

                    ),
                  ],
                ),
              ),

              if (badge != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xff557d5a),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    badge!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                )
              else
                Icon(
                  Icons.chevron_right_rounded,
                  color: Colors.black.withOpacity(0.22),
                  size: 34,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LogoutTile extends StatelessWidget {
  final VoidCallback onTap;

  const _LogoutTile({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xfffff5f2),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 92,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: const Color(0xffffe5e5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.logout_rounded,
                  color: DrawerView.danger,
                  size: 24,
                ),
              ),
              const SizedBox(width: 20),
              const Text(
                "Logout",
                style: TextStyle(
                  color: DrawerView.danger,
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}