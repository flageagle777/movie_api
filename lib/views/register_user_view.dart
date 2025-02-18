import 'package:flutter/material.dart';
import 'package:movie_api/services/user.dart';
import 'package:movie_api/views/dashboard.dart';
import 'package:movie_api/widgets/alert.dart';
import 'package:movie_api/views/login_view.dart';

class RegisterUserView extends StatefulWidget {
  const RegisterUserView({super.key});

  @override
  State<RegisterUserView> createState() => _RegisterUserViewState();
}

class _RegisterUserViewState extends State<RegisterUserView> {
  final UserService user = UserService();
  final formKey = GlobalKey<FormState>();

  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController birthday = TextEditingController();

  final List<String> roleChoice = ["admin", "kasir"];
  String? role;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register User"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            children: [
              const Text(
                "Register User",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: name,
                      decoration: const InputDecoration(labelText: "Name"),
                      validator: (value) =>
                          value!.isEmpty ? 'Nama harus diisi' : null,
                    ),
                    TextFormField(
                      controller: email,
                      decoration: const InputDecoration(labelText: "Email"),
                      validator: (value) =>
                          value!.isEmpty ? 'Email harus diisi' : null,
                    ),
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      value: role,
                      items: roleChoice.map((r) {
                        return DropdownMenuItem(value: r, child: Text(r));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          role = value;
                        });
                      },
                      hint: const Text("Pilih role"),
                      validator: (value) =>
                          value == null ? 'Role harus dipilih' : null,
                    ),
                    TextFormField(
                      controller: password,
                      decoration: const InputDecoration(labelText: "Password"),
                      obscureText: true,
                      validator: (value) =>
                          value!.isEmpty ? 'Password harus diisi' : null,
                    ),
                    TextFormField(
                      controller: address,
                      decoration: const InputDecoration(labelText: "Address"),
                      validator: (value) =>
                          value!.isEmpty ? 'Address harus diisi' : null,
                    ),
                    TextFormField(
                      controller: birthday,
                      decoration: const InputDecoration(labelText: "Birthday"),
                      validator: (value) =>
                          value!.isEmpty ? 'Birthday harus diisi' : null,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              var data = {
                                "name": name.text,
                                "email": email.text,
                                "role": role,
                                "password": password.text,
                                "address": address.text,
                                "birthday": birthday.text,
                              };
                              var result = await user.registerUser(data);

                              if (result.status == true) {
                                name.clear();
                                email.clear();
                                password.clear();
                                address.clear();
                                birthday.clear();
                                setState(() {
                                  role = null;
                                });

                                // Tampilkan alert
                                AlertMessage().showAlert(context, result.message, true);

                                // Arahkan ke Dashboard setelah registrasi berhasil
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const DashboardView(),
                                  ),
                                );
                              } else {
                                AlertMessage().showAlert(context, result.message, false);
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightGreen,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text("Register"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginView()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text("Go to Login"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
