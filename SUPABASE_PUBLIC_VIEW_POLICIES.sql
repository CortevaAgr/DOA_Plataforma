-- DOA: lectura pública + cambios autenticados/admin.
-- Este script NO borra ni modifica datos. Solo crea/ajusta políticas RLS.
-- La lectura pública permite que cualquier persona con el enlace consulte la información.
-- Si los datos de empleados no deben ser públicos, NO ejecutar estas políticas.

alter table public.perfiles enable row level security;
alter table public.estandares_doa enable row level security;
alter table public.usuarios enable row level security;
alter table public.cumplimiento enable row level security;

-- Lectura pública para la plataforma sin inicio de sesión.
drop policy if exists "Publico puede consultar perfiles DOA" on public.perfiles;
create policy "Publico puede consultar perfiles DOA"
on public.perfiles for select to anon, authenticated
using (true);

drop policy if exists "Publico puede consultar estandares DOA" on public.estandares_doa;
create policy "Publico puede consultar estandares DOA"
on public.estandares_doa for select to anon, authenticated
using (true);

drop policy if exists "Publico puede consultar usuarios DOA" on public.usuarios;
create policy "Publico puede consultar usuarios DOA"
on public.usuarios for select to anon, authenticated
using (true);

drop policy if exists "Publico puede consultar cumplimiento DOA" on public.cumplimiento;
create policy "Publico puede consultar cumplimiento DOA"
on public.cumplimiento for select to anon, authenticated
using (true);

-- Administración de datos maestros únicamente para usuarios autenticados con role=admin.
create or replace function public.is_doa_admin()
returns boolean
language sql stable security definer set search_path=public
as $$
  select coalesce((auth.jwt()->'app_metadata'->>'role')='admin', false);
$$;

drop policy if exists "Administradores pueden administrar perfiles" on public.perfiles;
create policy "Administradores pueden administrar perfiles"
on public.perfiles for all to authenticated
using (public.is_doa_admin())
with check (public.is_doa_admin());

drop policy if exists "Administradores pueden administrar estandares_doa" on public.estandares_doa;
create policy "Administradores pueden administrar estandares_doa"
on public.estandares_doa for all to authenticated
using (public.is_doa_admin())
with check (public.is_doa_admin());

drop policy if exists "Administradores pueden administrar usuarios" on public.usuarios;
create policy "Administradores pueden administrar usuarios"
on public.usuarios for all to authenticated
using (public.is_doa_admin())
with check (public.is_doa_admin());

-- Cumplimiento: cualquier usuario autenticado puede registrar/actualizar;
-- la eliminación queda restringida al administrador.
drop policy if exists "Usuarios autenticados pueden agregar cumplimiento" on public.cumplimiento;
create policy "Usuarios autenticados pueden agregar cumplimiento"
on public.cumplimiento for insert to authenticated
with check (true);

drop policy if exists "Usuarios autenticados pueden actualizar cumplimiento" on public.cumplimiento;
create policy "Usuarios autenticados pueden actualizar cumplimiento"
on public.cumplimiento for update to authenticated
using (true)
with check (true);

drop policy if exists "Administradores pueden eliminar cumplimiento" on public.cumplimiento;
create policy "Administradores pueden eliminar cumplimiento"
on public.cumplimiento for delete to authenticated
using (public.is_doa_admin());
