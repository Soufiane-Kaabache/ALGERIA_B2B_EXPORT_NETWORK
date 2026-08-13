'use client';

import { useEffect, useState } from 'react';
import { useRouter } from 'next/navigation';
import { createClient } from '@/utils/supabase/client';

type UserRole =
  | 'admin'
  | 'finance'
  | 'kyc_officer'
  | 'support'
  | 'moderator'
  | 'logistics'
  | 'catalog_manager'
  | 'developer';

interface RoleGuardProps {
  allowedRoles: UserRole[];
  children: React.ReactNode;
}

export function RoleGuard({ allowedRoles, children }: RoleGuardProps) {
  const router = useRouter();
  const [isAuthorized, setIsAuthorized] = useState<boolean | null>(null);
  const [userRole, setUserRole] = useState<UserRole | null>(null);
  const supabase = createClient();

  useEffect(() => {
    async function checkRole() {
      const {
        data: { user },
      } = await supabase.auth.getUser();

      if (!user) {
        router.push('/signin');
        return;
      }

      // Récupérer les rôles de l'utilisateur
      const { data: roles, error } = await supabase
        .from('user_roles')
        .select('role')
        .eq('user_id', user.id);

      if (error || !roles || roles.length === 0) {
        router.push('/account');
        return;
      }

      const userRoles = roles.map((r) => r.role as UserRole);
      const hasAccess = userRoles.some((role) => allowedRoles.includes(role));

      if (hasAccess) {
        setUserRole(userRoles[0]);
        setIsAuthorized(true);
      } else {
        router.push('/account');
      }
    }

    checkRole();
  }, [router, allowedRoles]);

  if (isAuthorized === null) {
    return (
      <div className="flex items-center justify-center min-h-screen">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-gray-900"></div>
      </div>
    );
  }

  if (!isAuthorized) {
    return null;
  }

  return <>{children}</>;
}