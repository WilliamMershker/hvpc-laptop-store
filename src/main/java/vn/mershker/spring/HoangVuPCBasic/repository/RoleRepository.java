package vn.mershker.spring.HoangVuPCBasic.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import vn.mershker.spring.HoangVuPCBasic.domain.Role;

import java.util.Optional;


public interface RoleRepository
        extends JpaRepository<Role, Long>
{
    Optional<Role> findByName(
            String name
    );
}