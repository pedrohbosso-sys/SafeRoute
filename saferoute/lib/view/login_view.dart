import 'package:flutter/material.dart';

import '../controller/app_controller.dart';
import 'widgets.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key, required this.controller, required this.onEnter});
  final AppController controller;
  final VoidCallback onEnter;

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final form = GlobalKey<FormState>();
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  bool register = false;
  bool hidden = true;
  bool loading = false;

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  Future<void> submit() async {
    if (!form.currentState!.validate()) return;
    setState(() => loading = true);
    try {
      if (register) {
        await widget.controller.signUp(
          name.text.trim(),
          email.text.trim(),
          password.text,
        );
        if (!mounted) return;
        if (widget.controller.authenticated) {
          widget.onEnter();
        } else {
          message(context, 'Conta criada. Confirme seu e-mail para entrar.');
        }
      } else {
        await widget.controller.signIn(email.text.trim(), password.text);
        if (mounted) {
          widget.onEnter();
        }
      }
    } catch (e) {
      if (mounted) message(context, e.toString());
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 460),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 28),
                  const Center(
                    child: CircleAvatar(
                      radius: 37,
                      backgroundColor: primary,
                      child: Icon(
                        Icons.water_drop_outlined,
                        size: 38,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'SafeRoute',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: ink,
                    ),
                  ),
                  const Text(
                    'Vias seguras e informação em tempo real',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFF64748B)),
                  ),
                  const SizedBox(height: 28),
                  card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SegmentedButton<bool>(
                          segments: const [
                            ButtonSegment(
                              value: false,
                              label: Text('Entrar'),
                              icon: Icon(Icons.login),
                            ),
                            ButtonSegment(
                              value: true,
                              label: Text('Cadastrar'),
                              icon: Icon(Icons.person_add_outlined),
                            ),
                          ],
                          selected: {register},
                          onSelectionChanged: (selection) =>
                              setState(() => register = selection.first),
                        ),
                        const SizedBox(height: 24),
                        if (register) ...[
                          TextFormField(
                            controller: name,
                            decoration: const InputDecoration(
                              labelText: 'Nome',
                              prefixIcon: Icon(Icons.person_outline),
                            ),
                            validator: (value) =>
                                value == null || value.trim().isEmpty
                                ? 'Informe seu nome'
                                : null,
                          ),
                          const SizedBox(height: 14),
                        ],
                        TextFormField(
                          controller: email,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'E-mail',
                            prefixIcon: Icon(Icons.mail_outline),
                          ),
                          validator: (value) =>
                              value == null || !value.contains('@')
                              ? 'Informe um e-mail válido'
                              : null,
                        ),
                        const SizedBox(height: 14),
                        TextFormField(
                          controller: password,
                          obscureText: hidden,
                          decoration: InputDecoration(
                            labelText: 'Senha',
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: Icon(
                                hidden
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                              ),
                              onPressed: () => setState(() => hidden = !hidden),
                            ),
                          ),
                          validator: (value) =>
                              value == null || value.length < 6
                              ? 'Use pelo menos 6 caracteres'
                              : null,
                        ),
                        if (!register)
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () async {
                                if (email.text.trim().isEmpty) {
                                  message(
                                    context,
                                    'Informe seu e-mail primeiro.',
                                  );
                                  return;
                                }
                                try {
                                  await widget.controller.resetPassword(
                                    email.text.trim(),
                                  );
                                  if (context.mounted) {
                                    message(
                                      context,
                                      'Verifique seu e-mail para recuperar a senha.',
                                    );
                                  }
                                } catch (e) {
                                  if (context.mounted) {
                                    message(context, e.toString());
                                  }
                                }
                              },
                              child: const Text('Esqueceu a senha?'),
                            ),
                          ),
                        const SizedBox(height: 14),
                        FilledButton.icon(
                          onPressed: loading ? null : submit,
                          icon: Icon(
                            register ? Icons.person_add : Icons.arrow_forward,
                          ),
                          label: Text(
                            loading
                                ? 'Aguarde...'
                                : register
                                ? 'Criar conta'
                                : 'Entrar',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  OutlinedButton.icon(
                    onPressed: widget.onEnter,
                    icon: const Icon(Icons.map_outlined),
                    label: const Text('Consultar mapa sem entrar'),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Para publicar ou confirmar ocorrências, entre em sua conta.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFF64748B)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
