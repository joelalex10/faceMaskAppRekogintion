
class Alerta{
  DateTime _hora;
  String _mensaje;

  Alerta(this._hora, this._mensaje);

  String get mensaje => _mensaje;

  set mensaje(String value) {
    _mensaje = value;
  }

  DateTime get hora => _hora;

  set hora(DateTime value) {
    _hora = value;
  }

  @override
  String toString() {
    return 'Alerta{_hora: $_hora, _mensaje: $_mensaje}';
  }
}