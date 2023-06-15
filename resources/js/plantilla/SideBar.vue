<template>
    <!-- Main Sidebar Container -->
    <aside class="main-sidebar sidebar-dark-primary elevation-4">
        <!-- Brand Logo -->
        <router-link
            exact
            :to="{ name: 'inicio' }"
            class="brand-link bg-primary"
        >
            <img
                :src="configuracion.path_image"
                alt="Logo"
                class="brand-image img-circle elevation-3"
                style="opacity: 0.8"
            />
            <span
                class="brand-text font-weight-light"
                v-text="configuracion.alias"
            ></span>
        </router-link>

        <!-- Sidebar -->
        <div class="sidebar">
            <!-- Sidebar user (optional) -->
            <div class="user-panel mt-3 pb-3 mb-3 d-flex">
                <div class="image">
                    <img
                        :src="user_sidebar.path_image"
                        class="img-circle elevation-2"
                        alt="User Image"
                    />
                </div>
                <div class="info">
                    <router-link
                        exact
                        :to="{
                            name: 'usuarios.perfil',
                            params: { id: user_sidebar.id },
                        }"
                        class="d-block"
                        v-text="user_sidebar.full_name"
                    ></router-link>
                </div>
            </div>

            <!-- SidebarSearch Form -->
            <div class="form-inline">
                <div class="input-group" data-widget="sidebar-search">
                    <input
                        class="form-control form-control-sidebar bg-white"
                        type="search"
                        placeholder="Buscar Modulo"
                        aria-label="Search"
                    />
                    <div class="input-group-append">
                        <button class="btn btn-sidebar bg-white">
                            <i class="fas fa-search fa-fw"></i>
                        </button>
                    </div>
                </div>
            </div>

            <!-- Sidebar Menu -->
            <nav class="mt-2">
                <ul
                    class="nav nav-pills nav-sidebar flex-column text-xs nav-flat"
                    data-widget="treeview"
                    role="menu"
                    data-accordion="false"
                >
                    <!-- Add icons to the links using the .nav-icon class with font-awesome or any other icon font library -->
                    <li class="nav-item">
                        <router-link
                            exact
                            :to="{ name: 'inicio' }"
                            class="nav-link"
                        >
                            <i class="nav-icon fas fa-home"></i>
                            <p>Inicio</p>
                        </router-link>
                    </li>
                    <li
                        class="nav-header bg-navy"
                        v-if="
                            permisos.includes('plan_mantenimientos.index') ||
                            permisos.includes('orden_trabajos.index') ||
                            permisos.includes('gama_mantenimientos.index') ||
                            permisos.includes('users.index') ||
                            permisos.includes('areas.index') ||
                            permisos.includes('sistemas.index') ||
                            permisos.includes('equipos.index') ||
                            permisos.includes('subunidads.index') ||
                            permisos.includes('maquinarias.index') ||
                            permisos.includes('variable_controls.index') ||
                            permisos.includes('frecuencias.index') ||
                            permisos.includes('herramientas.index') ||
                            permisos.includes('entrada_herramientas.index') ||
                            permisos.includes('repuestos.index') ||
                            permisos.includes('entrada_repuestos.index') ||
                            permisos.includes('personals.index')
                        "
                    >
                        ADMINISTRACIÓN
                    </li>
                    <li
                        class="nav-item"
                        v-if="permisos.includes('plan_mantenimientos.index')"
                    >
                        <router-link
                            :to="{ name: 'plan_mantenimientos.index' }"
                            class="nav-link"
                            v-loading.fullscreen.lock="fullscreenLoading"
                        >
                            <i class="nav-icon fas fa-clipboard-list"></i>
                            <p>Plan de Mantenimiento</p>
                        </router-link>
                    </li>
                    <li
                        class="nav-item"
                        v-if="
                            permisos.includes('gama_mantenimientos.index') ||
                            permisos.includes('familias.index') ||
                            permisos.includes('sub_familias.index')
                        "
                        :class="[
                            $route.name == 'gama_mantenimientos.index' ||
                            $route.name == 'gama_mantenimientos.create' ||
                            $route.name == 'gama_mantenimientos.edit' ||
                            $route.name == 'familias.index' ||
                            $route.name == 'sub_familias.index'
                                ? 'menu-is-opening menu-open'
                                : '',
                        ]"
                    >
                        <a href="#" class="nav-link">
                            <i class="nav-icon fas fa-boxes"></i>
                            <p>
                                Gama de mantenimiento
                                <i class="right fas fa-angle-left"></i>
                            </p>
                        </a>
                        <ul
                            class="nav nav-treeview"
                            :style.display="[
                                $route.name == 'gama_mantenimientos.index' ||
                                $route.name == 'familias.index' ||
                                $route.name == 'sub_familias.index'
                                    ? 'block'
                                    : '',
                            ]"
                        >
                            <li
                                class="nav-item"
                                v-if="
                                    permisos.includes(
                                        'gama_mantenimientos.index'
                                    )
                                "
                            >
                                <router-link
                                    exact
                                    :to="{ name: 'gama_mantenimientos.index' }"
                                    class="nav-link"
                                    :class="[
                                        $route.name ==
                                            'gama_mantenimientos.create' ||
                                        $route.name ==
                                            'gama_mantenimientos.edit'
                                            ? 'active'
                                            : '',
                                    ]"
                                    v-loading.fullscreen.lock="
                                        fullscreenLoading
                                    "
                                >
                                    <i class="nav-icon fas fa-angle-right"></i>
                                    <p>Gama de Mantenimiento</p>
                                </router-link>
                            </li>
                            <li
                                class="nav-item"
                                v-if="permisos.includes('familias.index')"
                            >
                                <router-link
                                    exact
                                    :to="{ name: 'familias.index' }"
                                    class="nav-link"
                                    v-loading.fullscreen.lock="
                                        fullscreenLoading
                                    "
                                >
                                    <i class="nav-icon fas fa-angle-right"></i>
                                    <p>Familias</p>
                                </router-link>
                            </li>
                            <li
                                class="nav-item"
                                v-if="permisos.includes('sub_familias.index')"
                            >
                                <router-link
                                    exact
                                    :to="{ name: 'sub_familias.index' }"
                                    class="nav-link"
                                    v-loading.fullscreen.lock="
                                        fullscreenLoading
                                    "
                                >
                                    <i class="nav-icon fas fa-angle-right"></i>
                                    <p>Subfamilias</p>
                                </router-link>
                            </li>
                        </ul>
                    </li>
                    <li
                        class="nav-item"
                        v-if="permisos.includes('areas.index')"
                    >
                        <router-link
                            exact
                            :to="{ name: 'areas.index' }"
                            class="nav-link"
                            v-loading.fullscreen.lock="fullscreenLoading"
                        >
                            <i class="nav-icon fas fa-list"></i>
                            <p>Áreas</p>
                        </router-link>
                    </li>
                    <li
                        class="nav-item"
                        v-if="permisos.includes('sistemas.index')"
                    >
                        <router-link
                            exact
                            :to="{ name: 'sistemas.index' }"
                            class="nav-link"
                            v-loading.fullscreen.lock="fullscreenLoading"
                        >
                            <i class="nav-icon fas fa-list"></i>
                            <p>Sistemas</p>
                        </router-link>
                    </li>
                    <li
                        class="nav-item"
                        v-if="permisos.includes('equipos.index')"
                    >
                        <router-link
                            exact
                            :to="{ name: 'equipos.index' }"
                            class="nav-link"
                            v-loading.fullscreen.lock="fullscreenLoading"
                        >
                            <i class="nav-icon fas fa-list"></i>
                            <p>Equipos</p>
                        </router-link>
                    </li>
                    <li
                        class="nav-item"
                        v-if="permisos.includes('subunidads.index')"
                    >
                        <router-link
                            exact
                            :to="{ name: 'subunidads.index' }"
                            class="nav-link"
                            v-loading.fullscreen.lock="fullscreenLoading"
                        >
                            <i class="nav-icon fas fa-tags"></i>
                            <p>Subunidades</p>
                        </router-link>
                    </li>
                    <li
                        class="nav-item"
                        v-if="permisos.includes('maquinarias.index')"
                    >
                        <router-link
                            :to="{ name: 'maquinarias.index' }"
                            class="nav-link"
                            v-loading.fullscreen.lock="fullscreenLoading"
                        >
                            <i class="nav-icon fas fa-truck-loading"></i>
                            <p>Maquinaria</p>
                        </router-link>
                    </li>
                    <li
                        class="nav-item"
                        v-if="permisos.includes('variable_controls.index')"
                        :class="[
                            $route.name == 'variable_controls.index' ||
                            $route.name == 'frecuencias.index'
                                ? 'menu-is-opening menu-open'
                                : '',
                        ]"
                    >
                        <a href="#" class="nav-link">
                            <i class="nav-icon fas fa-tasks"></i>
                            <p>
                                Variables de control
                                <i class="right fas fa-angle-left"></i>
                            </p>
                        </a>
                        <ul
                            class="nav nav-treeview"
                            :style.display="[
                                $route.name == 'variable_controls.index' ||
                                $route.name == 'frecuencias.index'
                                    ? 'block'
                                    : '',
                            ]"
                        >
                            <li class="nav-item">
                                <router-link
                                    exact
                                    :to="{ name: 'variable_controls.index' }"
                                    class="nav-link"
                                    v-loading.fullscreen.lock="
                                        fullscreenLoading
                                    "
                                >
                                    <i class="nav-icon fas fa-angle-right"></i>
                                    <p>Variables de control</p>
                                </router-link>
                            </li>
                            <li
                                class="nav-item"
                                v-if="permisos.includes('frecuencias.index')"
                            >
                                <router-link
                                    exact
                                    :to="{ name: 'frecuencias.index' }"
                                    class="nav-link"
                                    v-loading.fullscreen.lock="
                                        fullscreenLoading
                                    "
                                >
                                    <i class="nav-icon fas fa-angle-right"></i>
                                    <p>Frecuencias</p>
                                </router-link>
                            </li>
                        </ul>
                    </li>
                    <li
                        class="nav-item"
                        v-if="permisos.includes('herramientas.index')"
                        :class="[
                            $route.name == 'herramientas.index' ||
                            $route.name == 'entrada_herramientas.index'
                                ? 'menu-is-opening menu-open'
                                : '',
                        ]"
                    >
                        <a href="#" class="nav-link">
                            <i class="nav-icon fas fa-boxes"></i>
                            <p>
                                Herramientas y Equipos de protección
                                <i class="right fas fa-angle-left"></i>
                            </p>
                        </a>
                        <ul
                            class="nav nav-treeview"
                            :style.display="[
                                $route.name == 'herramientas.index' ||
                                $route.name == 'entrada_herramientas.index'
                                    ? 'block'
                                    : '',
                            ]"
                        >
                            <li
                                class="nav-item"
                                v-if="permisos.includes('herramientas.index')"
                            >
                                <router-link
                                    exact
                                    :to="{ name: 'herramientas.index' }"
                                    class="nav-link"
                                    v-loading.fullscreen.lock="
                                        fullscreenLoading
                                    "
                                >
                                    <i class="nav-icon fas fa-angle-right"></i>
                                    <p>Herramientas y Equipos de protección</p>
                                </router-link>
                            </li>
                            <li
                                class="nav-item"
                                v-if="
                                    permisos.includes(
                                        'entrada_herramientas.index'
                                    )
                                "
                            >
                                <router-link
                                    exact
                                    :to="{ name: 'entrada_herramientas.index' }"
                                    class="nav-link"
                                    v-loading.fullscreen.lock="
                                        fullscreenLoading
                                    "
                                >
                                    <i class="nav-icon fas fa-angle-right"></i>
                                    <p>
                                        Entrada de Herramientas y Equipos de
                                        protección
                                    </p>
                                </router-link>
                            </li>
                        </ul>
                    </li>
                    <li
                        class="nav-item"
                        v-if="permisos.includes('repuestos.index')"
                        :class="[
                            $route.name == 'repuestos.index' ||
                            $route.name == 'entrada_repuestos.index'
                                ? 'menu-is-opening menu-open'
                                : '',
                        ]"
                    >
                        <a href="#" class="nav-link">
                            <i class="nav-icon fas fa-boxes"></i>
                            <p>
                                Repuestos e Insumos
                                <i class="right fas fa-angle-left"></i>
                            </p>
                        </a>
                        <ul
                            class="nav nav-treeview"
                            :style.display="[
                                $route.name == 'repuestos.index' ||
                                $route.name == 'entrada_herramientas.index'
                                    ? 'block'
                                    : '',
                            ]"
                        >
                            <li
                                class="nav-item"
                                v-if="permisos.includes('repuestos.index')"
                            >
                                <router-link
                                    exact
                                    :to="{ name: 'repuestos.index' }"
                                    class="nav-link"
                                    v-loading.fullscreen.lock="
                                        fullscreenLoading
                                    "
                                >
                                    <i class="nav-icon fas fa-angle-right"></i>
                                    <p>Repuestos e Insumos</p>
                                </router-link>
                            </li>
                            <li
                                class="nav-item"
                                v-if="
                                    permisos.includes('entrada_repuestos.index')
                                "
                            >
                                <router-link
                                    exact
                                    :to="{ name: 'entrada_repuestos.index' }"
                                    class="nav-link"
                                    v-loading.fullscreen.lock="
                                        fullscreenLoading
                                    "
                                >
                                    <i class="nav-icon fas fa-angle-right"></i>
                                    <p>Entrada de Repuestos e Insumos</p>
                                </router-link>
                            </li>
                        </ul>
                    </li>
                    <li
                        class="nav-item"
                        v-if="permisos.includes('orden_trabajos.index')"
                    >
                        <router-link
                            exact
                            :to="{ name: 'orden_trabajos.index' }"
                            class="nav-link"
                            v-loading.fullscreen.lock="fullscreenLoading"
                        >
                            <i class="nav-icon fas fa-file-archive"></i>
                            <p>Ordenes de trabajo</p>
                        </router-link>
                    </li>
                    <li
                        class="nav-item"
                        v-if="permisos.includes('personals.index')"
                    >
                        <router-link
                            exact
                            :to="{ name: 'personals.index' }"
                            class="nav-link"
                            v-loading.fullscreen.lock="fullscreenLoading"
                        >
                            <i class="nav-icon fas fa-users"></i>
                            <p>Personal</p>
                        </router-link>
                    </li>
                    <li
                        class="nav-item"
                        v-if="permisos.includes('usuarios.index')"
                    >
                        <router-link
                            exact
                            :to="{ name: 'usuarios.index' }"
                            class="nav-link"
                            v-loading.fullscreen.lock="fullscreenLoading"
                        >
                            <i class="nav-icon fas fa-users"></i>
                            <p>Usuarios</p>
                        </router-link>
                    </li>
                    <li
                        class="nav-header bg-navy"
                        v-if="
                            permisos.includes('reportes.usuarios') ||
                            permisos.includes('reportes.kardex_herramientas') ||
                            permisos.includes(
                                'reportes.informacion_herramientas'
                            )
                        "
                    >
                        REPORTES
                    </li>
                    <li
                        class="nav-item"
                        v-if="permisos.includes('reportes.usuarios')"
                    >
                        <router-link
                            :to="{ name: 'reportes.usuarios' }"
                            class="nav-link"
                        >
                            <i class="fas fa-file-pdf nav-icon"></i>
                            <p>Lista de Usuarios</p>
                        </router-link>
                    </li>
                    <!-- <li
                        class="nav-item"
                        v-if="permisos.includes('reportes.kardex_herramientas')"
                    >
                        <router-link
                            :to="{ name: 'reportes.kardex_herramientas' }"
                            class="nav-link"
                        >
                            <i class="fas fa-file-pdf nav-icon"></i>
                            <p>
                                Kardex de herramientas y equipos de protección
                            </p>
                        </router-link>
                    </li>
                    <li
                        class="nav-item"
                        v-if="
                            permisos.includes(
                                'reportes.informacion_herramientas'
                            )
                        "
                    >
                        <router-link
                            :to="{ name: 'reportes.informacion_herramientas' }"
                            class="nav-link"
                        >
                            <i class="fas fa-file-pdf nav-icon"></i>
                            <p>Información de herramientas</p>
                        </router-link>
                    </li> -->
                    <li class="nav-header bg-navy">OTRAS OPCIONES</li>
                    <li
                        class="nav-item"
                        v-if="permisos.includes('configuracion.index')"
                    >
                        <router-link
                            :to="{ name: 'configuracion' }"
                            class="nav-link"
                        >
                            <i class="nav-icon fas fa-cog"></i>
                            <p>Configuración</p>
                        </router-link>
                    </li>
                    <li class="nav-item">
                        <router-link
                            exact
                            :to="{
                                name: 'usuarios.perfil',
                                params: { id: user_sidebar.id },
                            }"
                            class="nav-link"
                        >
                            <i class="nav-icon fas fa-user"></i>
                            <p>Perfil</p>
                        </router-link>
                    </li>
                    <li class="nav-item">
                        <a
                            href="#"
                            class="nav-link"
                            @click.prevent="logout()"
                            v-loading.fullscreen.lock="fullscreenLoading"
                        >
                            <i class="fas fa-power-off nav-icon"></i>
                            <p>Salir</p>
                        </a>
                    </li>
                </ul>
            </nav>
            <!-- /.sidebar-menu -->
        </div>
        <!-- /.sidebar -->
    </aside>
</template>

<script>
export default {
    props: ["user_sidebar", "configuracion"],
    data() {
        return {
            user: JSON.parse(localStorage.getItem("user")),
            fullscreenLoading: false,
            permisos: localStorage.getItem("permisos"),
        };
    },
    methods: {
        logout() {
            this.fullscreenLoading = true;
            axios.post("/logout").then((res) => {
                setTimeout(function () {
                    localStorage.clear();
                    location.reload();
                    this.$router.push({ name: "login" });
                }, 500);
            });
        },
    },
};
</script>

<style>
.user-panel .info {
    display: flex;
    height: 100%;
    align-items: center;
}
.user-panel .info a {
    font-size: 0.8em;
}
</style>
