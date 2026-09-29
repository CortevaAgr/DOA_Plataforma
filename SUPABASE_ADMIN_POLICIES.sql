-- Permisos administrativos para la plataforma DOA. No borra datos.
create or replace function public.is_doa_admin() returns boolean language sql stable security definer set search_path=public as $$ select coalesce((auth.jwt()->'app_metadata'->>'role')='admin',false); $$;

drop policy if exists "Administradores pueden administrar perfiles" on public.perfiles;
create policy "Administradores pueden administrar perfiles" on public.perfiles for all to authenticated using (public.is_doa_admin()) with check (public.is_doa_admin());

drop policy if exists "Administradores pueden administrar estandares_doa" on public.estandares_doa;
create policy "Administradores pueden administrar estandares_doa" on public.estandares_doa for all to authenticated using (public.is_doa_admin()) with check (public.is_doa_admin());

drop policy if exists "Administradores pueden administrar usuarios" on public.usuarios;
create policy "Administradores pueden administrar usuarios" on public.usuarios for all to authenticated using (public.is_doa_admin()) with check (public.is_doa_admin());
