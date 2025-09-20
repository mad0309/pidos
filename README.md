
# Pidos App | El Sistema de Puntos que Premia tu Lealtad 🚀

<div align="center">
<img src="./assets/readme-img/portada.png" alt="Banner de la aplicación Pidos" />
<br/>
**¡Gana. Canjea. Disfruta!**
</div>

---

## 📄 Descripción del Proyecto

**Pidos** es una moderna aplicación móvil desarrollada con **Flutter** que funciona como un sistema de recompensas. Los usuarios pueden acumular puntos por sus compras o interacciones, y luego canjearlos por una variedad de beneficios exclusivos, descuentos y productos. La aplicación ofrece una experiencia fluida y gratificante, diseñada para fidelizar a los clientes y mejorar la relación con la marca.

---

## ✨ Características Principales

* **Acumulación de Puntos:** Los usuarios ganan puntos automáticamente por cada transacción, basados en reglas de negocio predefinidas.
* **Canje de Recompensas:** Un catálogo de recompensas atractivo donde los puntos pueden ser canjeados por productos, servicios o descuentos.
* **Historial de Transacciones:** Visualización detallada de los puntos ganados y canjeados, lo que permite un control total sobre la cuenta.
* **Autenticación Segura:** Inicio de sesión y registro de usuarios robustos, respaldados por la seguridad de Firebase.
* **Notificaciones:** Alertas en tiempo real sobre nuevas ofertas, cambios en el saldo de puntos y promociones especiales.

---

## 🛠️ Tecnologías Utilizadas

* **Flutter:** Framework para la construcción de la interfaz de usuario.
* **Dart:** Lenguaje de programación.
* **Firebase:**
    * **Firebase Authentication:** Para la gestión de usuarios.
    * **Cloud Firestore:** Base de datos NoSQL para almacenar datos de puntos, usuarios y transacciones en tiempo real.
    * **Firebase Cloud Messaging:** Para notificaciones push.
* **RxDart:** Gestión de estado para una arquitectura escalable.

---

## ⚙️ Instalación y Configuración

Sigue estos pasos para tener una copia local del proyecto en funcionamiento.

### Prerrequisitos
Asegúrate de tener instalado Flutter y un editor de código compatible (como VS Code con la extensión de Flutter).

### 1. Clonar el repositorio
```bash
git clone https://github.com/mad0309/pidos.git
cd pidos
```

### 2\. Instalar dependencias

Desde la raíz del proyecto, ejecuta el siguiente comando para instalar todas las dependencias:

```bash
flutter pub get
```

### 3\. Ejecutar la aplicación

Con un emulador o un dispositivo físico conectado, puedes ejecutar la aplicación con:

```bash
flutter run
```

-----

## 📁 Estructura del Proyecto

La estructura del proyecto sigue una organización limpia y modular, facilitando el mantenimiento y la escalabilidad.

```
lib/
├── main.dart             # Punto de entrada de la aplicación
├── route_generator.dart  # Punto de generacion de rutar/pantallas de la aplicacion
├── data/                 # Contiene algunos datos a usar
├── domain/               # Modelos de datos (User, Transaction, Reward)
├── presentation/         # Lógica para interactuar con APIs y widgets
└── utils/                # Funciones de utilidad
```

-----

## 📸 Capturas de Pantalla

[Añade aquí las capturas de pantalla de tu aplicación para mostrar su UI/UX. Puedes usar el siguiente formato:]

-----

## 🤝 Contribuciones

¡Tu colaboración es bienvenida\! Si deseas contribuir, sigue estos pasos:

1.  Haz un "fork" de este repositorio.
2.  Crea una nueva rama (`git checkout -b feature/nueva-funcionalidad`).
3.  Realiza tus cambios y haz "commit" de ellos (`git commit -m 'feat: añade nueva funcionalidad'`).
4.  Empuja la rama a tu "fork" (`git push origin feature/nueva-funcionalidad`).
5.  Crea un **Pull Request** detallando tus cambios.

-----

## 📧 Contacto

Para cualquier pregunta o sugerencia, no dudes en contactarnos:

  * **Nombre del Autor:** Martin Alvarado
  * **Email:** ma.alvarado0309@gmail.com
  * **GitHub:** @mad0309
