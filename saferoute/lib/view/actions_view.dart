import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';

import '../controller/app_controller.dart';
import 'widgets.dart';

class ActionsView extends StatefulWidget {
  const ActionsView({
    super.key,
    required this.controller,
    required this.onDone,
  });
  final AppController controller;
  final VoidCallback onDone;

  @override
  State<ActionsView> createState() => _ActionsViewState();
}

class _ActionsViewState extends State<ActionsView> {
  final description = TextEditingController();
  String type = 'alagamento';
  int severity = 1;
  bool saving = false;
  LatLng? adjustedPoint;
  Uint8List? photoBytes;

  @override
  void dispose() {
    description.dispose();
    super.dispose();
  }

  Future<void> submit() async {
    setState(() => saving = true);
    try {
      final photoSaved = await widget.controller.report(
        type: type,
        description: description.text.trim(),
        point: adjustedPoint ?? widget.controller.position,
        severity: severity,
        photoBytes: photoBytes,
      );
      if (!mounted) return;
      description.clear();
      photoBytes = null;
      message(
        context,
        photoSaved
            ? 'Ocorrência enviada. Obrigado por colaborar!'
            : 'Ocorrência enviada, mas a foto não pôde ser anexada.',
      );
      widget.onDone();
    } catch (e) {
      if (mounted) message(context, e.toString());
    } finally {
      if (mounted) setState(() => saving = false);
    }
  }

  Future<void> pickPhoto(ImageSource source) async {
    try {
      final photo = await ImagePicker().pickImage(
        source: source,
        imageQuality: 75,
        maxWidth: 1600,
      );
      if (photo == null) return;
      final bytes = await photo.readAsBytes();
      if (mounted) setState(() => photoBytes = bytes);
    } catch (e) {
      if (mounted) message(context, 'Não foi possível adicionar a foto: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final point = adjustedPoint ?? widget.controller.position;
    return SafeArea(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 18, 20, 12),
            child: Row(
              children: [
                Icon(Icons.add_alert, color: primary),
                SizedBox(width: 10),
                Text(
                  'Reportar ocorrência',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: ink,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              children: [
                card(
                  child: Row(
                    children: [
                      const Icon(Icons.gps_fixed, color: primary),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          widget.controller.locationAvailable
                              ? 'Localização obtida pelo GPS. Relatos ajudam outros motoristas a evitar riscos.'
                              : 'GPS indisponível. Ative a localização ou ajuste as coordenadas antes de publicar.',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Tipo de incidente',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: ink,
                  ),
                ),
                const SizedBox(height: 10),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1.6,
                  children: [
                    _typeCard('alagamento', 'Alagamento', Icons.water),
                    _typeCard('enchente', 'Enchente', Icons.flood),
                    _typeCard('obras', 'Obras', Icons.construction),
                    _typeCard('interdicao', 'Interdição', Icons.block),
                  ],
                ),
                const SizedBox(height: 22),
                const Text(
                  'Gravidade',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: ink,
                  ),
                ),
                const SizedBox(height: 8),
                ...[
                  (1, 'Baixa', 'Transitável com cautela'),
                  (2, 'Moderada', 'Desvio recomendado'),
                  (3, 'Alta', 'Via intransitável'),
                ].map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 7),
                    child: card(
                      padding: EdgeInsets.zero,
                      child: ListTile(
                        onTap: () => setState(() => severity = item.$1),
                        leading: Icon(
                          severity == item.$1
                              ? Icons.radio_button_checked
                              : Icons.radio_button_unchecked,
                          color: primary,
                        ),
                        title: Text(item.$2),
                        subtitle: Text(item.$3),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Local da ocorrência',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: ink,
                  ),
                ),
                const SizedBox(height: 8),
                card(
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.location_on, color: primary),
                        title: const Text('Ponto selecionado'),
                        subtitle: Text(
                          '${point.latitude.toStringAsFixed(5)}, ${point.longitude.toStringAsFixed(5)}',
                        ),
                      ),
                      OutlinedButton.icon(
                        onPressed: () => _adjustPoint(context),
                        icon: const Icon(Icons.edit_location_alt),
                        label: const Text('Ajustar coordenadas'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Descrição da situação',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: ink,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: description,
                  maxLines: 4,
                  maxLength: 500,
                  decoration: const InputDecoration(
                    hintText:
                        'Descreva a altura da água, faixa bloqueada ou outro detalhe útil...',
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Evidência visual (opcional)',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: ink,
                  ),
                ),
                const SizedBox(height: 8),
                if (photoBytes != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.memory(
                      photoBytes!,
                      height: 170,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                Wrap(
                  spacing: 8,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () => pickPhoto(ImageSource.camera),
                      icon: const Icon(Icons.photo_camera),
                      label: const Text('Câmera'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => pickPhoto(ImageSource.gallery),
                      icon: const Icon(Icons.photo_library_outlined),
                      label: const Text('Galeria'),
                    ),
                    if (photoBytes != null)
                      TextButton(
                        onPressed: () => setState(() => photoBytes = null),
                        child: const Text('Remover'),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                if (!widget.controller.authenticated)
                  const Text(
                    'Entre em sua conta para enviar o registro.',
                    style: TextStyle(color: danger),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: FilledButton.icon(
              onPressed: saving ? null : submit,
              icon: const Icon(Icons.send),
              label: Text(
                saving ? 'Enviando...' : 'Enviar registro de ocorrência',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _typeCard(String value, String label, IconData icon) {
    final selected = type == value;
    return InkWell(
      onTap: () => setState(() => type = value),
      child: Container(
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFE8F5F6) : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected ? primary : const Color(0xFFDDE5E8),
            width: selected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: selected ? primary : ink),
            const SizedBox(height: 6),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Future<void> _adjustPoint(BuildContext context) async {
    final latitude = TextEditingController(
      text: widget.controller.position.latitude.toStringAsFixed(5),
    );
    final longitude = TextEditingController(
      text: widget.controller.position.longitude.toStringAsFixed(5),
    );
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Ajustar localização'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: latitude,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: true,
              ),
              decoration: const InputDecoration(labelText: 'Latitude'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: longitude,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: true,
              ),
              decoration: const InputDecoration(labelText: 'Longitude'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              final lat = double.tryParse(latitude.text.replaceAll(',', '.'));
              final lng = double.tryParse(longitude.text.replaceAll(',', '.'));
              if (lat == null ||
                  lng == null ||
                  lat.abs() > 90 ||
                  lng.abs() > 180) {
                message(context, 'Coordenadas inválidas.');
                return;
              }
              setState(() => adjustedPoint = LatLng(lat, lng));
              Navigator.pop(dialogContext);
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
    latitude.dispose();
    longitude.dispose();
  }
}
