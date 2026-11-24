import 'package:flutter_test/flutter_test.dart';
import 'package:saferoute/model/ocorrencia.dart';

void main() {
  test('ocorrência lê chaves numéricas e validações do Supabase', () {
    final item = Ocorrencia.fromJson({
      'id': 12,
      'usuario_id': 'user-uuid',
      'local_id': 8,
      'tipo': 'alagamento',
      'descricao': 'Água na pista',
      'gravidade': 3,
      'status': 'ativa',
      'data_ocorrencia': '2026-11-24T12:00:00Z',
      'validade': '2026-11-24T16:00:00Z',
      'local': {
        'id': 8,
        'endereco': 'Rua Teste',
        'latitude': -22.7,
        'longitude': -47.3,
      },
      'confirmacao': [
        {'confirmada': true},
        {'confirmada': true},
        {'confirmada': false},
      ],
    });

    expect(item.id, 12);
    expect(item.local?.id, 8);
    expect(item.gravidade, 3);
    expect(item.confirmadas, 2);
    expect(item.contestadas, 1);
  });
}
