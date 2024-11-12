import 'package:cafemixes/model/Receta.dart';

import 'Usuario.dart';
class AplicacionCafe {
  late Usuario _usuarioActual;

  Usuario get usuarioActual => _usuarioActual;

  set usuarioActual(Usuario value) {
    _usuarioActual = value;
  }
  late List<Receta> listaRecetas;

  void iniciarSesion(String email, String password) {
  }

  void registrarUsuario(String nombre, String email) {
  }

  List<Receta> buscarReceta(String nombre) {
    return [];
  }

  List<Receta> filtrarRecetasPorTipo(String tipoCafe) {
    return [];
  }
}
