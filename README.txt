GESTIÓN DE AUTORIZACIONES – DOA
Corteva | Massy Energy

VERSIÓN: Supabase + GitHub Pages / acceso público + cambios protegidos

ESTADO DE ESTA VERSIÓN: conexión REST corregida y Publishable Key verificada contra la clave proporcionada para el proyecto DOA-Corteva.

1. BASE DE DATOS
La plataforma usa el proyecto Supabase DOA-Corteva como base de datos central.
No contiene datos ficticios en el JavaScript.

2. ACCESO PÚBLICO
Cualquier persona con el enlace puede consultar Dashboard, Usuarios y Consultar Requisitos.
La lectura pública depende de las políticas RLS incluidas en SUPABASE_PUBLIC_VIEW_POLICIES.sql.
IMPORTANTE: esas políticas hacen públicos los datos de usuarios y cumplimiento. Ejecutarlas solo si ese nivel de visibilidad es el deseado.

3. CAMBIOS
Agregar, actualizar, eliminar e importar información exige iniciar sesión con un usuario de Supabase.
La sesión usa Supabase Auth; no se utiliza una contraseña administrativa escrita dentro del HTML.

4. CLAVE DEL FRONTEND
Se utiliza únicamente la Publishable Key sb_publishable_... en el navegador. Nunca se incluye una Secret Key.
La Publishable Key se envía por el encabezado `apikey`. Cuando existe una sesión, el JWT del usuario se envía por `Authorization: Bearer <JWT>`.

5. SQL
Ejecute una sola vez SUPABASE_PUBLIC_VIEW_POLICIES.sql en Supabase SQL Editor para permitir la lectura pública y mantener los cambios protegidos por autenticación/RLS.

6. GITHUB PAGES
Suba el contenido de la carpeta DOA_Plataforma al repositorio, conservando index.html en la raíz del sitio publicado.

7. DATOS EXISTENTES
Este paquete NO borra ni reinicia datos de Supabase.
