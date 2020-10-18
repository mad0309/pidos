
part of 'usuario_repository_impl.dart';

abstract class _Mappers {
  
  /// Entity => Domain
  static AuthenticationState usuarioAndTokenEntityToDomainAuthState(UsuarioEntity usuarioEntity) {
    if(usuarioEntity == null){
      return UnauthenticatedState();
    }

    final usuarioBuilder = _Mappers.usuarioEntityToUsuarioDomain(usuarioEntity);
    
    return AuthenticatedState((b) => b.usuario = usuarioBuilder);
  }


  /// Entity => Domain
  static UsuarioBuilder usuarioEntityToUsuarioDomain(UsuarioEntity usuarioEntity) {
    return UsuarioBuilder()
      ..id=usuarioEntity.id
      ..name=usuarioEntity.name
      ..lastName = usuarioEntity.lastName
      ..email = usuarioEntity.email
      ..document=usuarioEntity.document
      ..pid=usuarioEntity.pid
      ..pidcash=usuarioEntity.pidcash
      ..shortName = usuarioEntity.shortName
      ..role=usuarioEntity.role
      ..firstName=usuarioEntity.firstName;
  }

  /// Domain -> Entity
  static UsuarioEntityBuilder usuarioDomainToUserEntity(Usuario usuario) {
    return UsuarioEntityBuilder()
      ..id=usuario.id
      ..name=usuario.name
      ..lastName = usuario.lastName
      ..email = usuario.email
      ..document = usuario.document
      ..pid=usuario.pid
      ..pidcash=usuario.pidcash
      ..shortName = usuario.shortName
      ..role = usuario.role
      ..firstName=usuario.firstName;
  }






}