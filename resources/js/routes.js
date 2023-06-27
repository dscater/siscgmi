import Vue from "vue";
import Router from "vue-router";

Vue.use(Router);

export default new Router({
    routes: [
        // INICIO
        {
            path: "/",
            name: "inicio",
            component: require("./components/Inicio.vue").default,
        },

        // LOGIN
        {
            path: "/login",
            name: "login",
            component: require("./Auth.vue").default,
        },

        // Usuarios
        {
            path: "/usuarios/perfil/:id",
            name: "usuarios.perfil",
            component: require("./components/modulos/usuarios/perfil.vue")
                .default,
            props: true,
        },
        {
            path: "/usuarios",
            name: "usuarios.index",
            component: require("./components/modulos/usuarios/index.vue")
                .default,
        },

        // Configuración
        {
            path: "/configuracion",
            name: "configuracion",
            component: require("./components/modulos/configuracion/index.vue")
                .default,
            props: true,
        },

        // areas
        {
            path: "/areas",
            name: "areas.index",
            component: require("./components/modulos/areas/index.vue").default,
        },

        // sistemas
        {
            path: "/sistemas",
            name: "sistemas.index",
            component: require("./components/modulos/sistemas/index.vue")
                .default,
        },

        // equipos
        {
            path: "/equipos",
            name: "equipos.index",
            component: require("./components/modulos/equipos/index.vue")
                .default,
        },

        // subunidads
        {
            path: "/subunidads",
            name: "subunidads.index",
            component: require("./components/modulos/subunidads/index.vue")
                .default,
        },

        // maquinarias
        {
            path: "/maquinarias",
            name: "maquinarias.index",
            component: require("./components/modulos/maquinarias/index.vue")
                .default,
        },
        {
            path: "/maquinarias/create",
            name: "maquinarias.create",
            component: require("./components/modulos/maquinarias/create.vue")
                .default,
        },
        {
            path: "/maquinarias/:id",
            name: "maquinarias.edit",
            component: require("./components/modulos/maquinarias/edit.vue")
                .default,
            props: true,
        },

        // variable_controls
        {
            path: "/variable_controls",
            name: "variable_controls.index",
            component:
                require("./components/modulos/variable_controls/index.vue")
                    .default,
        },

        // frecuencias
        {
            path: "/frecuencias",
            name: "frecuencias.index",
            component: require("./components/modulos/frecuencias/index.vue")
                .default,
        },

        // herramientas
        {
            path: "/herramientas",
            name: "herramientas.index",
            component: require("./components/modulos/herramientas/index.vue")
                .default,
        },
        {
            path: "/herramientas/create",
            name: "herramientas.create",
            component: require("./components/modulos/herramientas/create.vue")
                .default,
        },
        {
            path: "/herramientas/:id",
            name: "herramientas.edit",
            component: require("./components/modulos/herramientas/edit.vue")
                .default,
            props: true,
        },

        // entrada_herramientas
        {
            path: "/entrada_herramientas",
            name: "entrada_herramientas.index",
            component:
                require("./components/modulos/entrada_herramientas/index.vue")
                    .default,
        },

        // repuestos
        {
            path: "/repuestos",
            name: "repuestos.index",
            component: require("./components/modulos/repuestos/index.vue")
                .default,
        },
        {
            path: "/repuestos/create",
            name: "repuestos.create",
            component: require("./components/modulos/repuestos/create.vue")
                .default,
        },
        {
            path: "/repuestos/:id",
            name: "repuestos.edit",
            component: require("./components/modulos/repuestos/edit.vue")
                .default,
            props: true,
        },

        // entrada_repuestos
        {
            path: "/entrada_repuestos",
            name: "entrada_repuestos.index",
            component:
                require("./components/modulos/entrada_repuestos/index.vue")
                    .default,
        },

        // personals
        {
            path: "/personals",
            name: "personals.index",
            component: require("./components/modulos/personals/index.vue")
                .default,
        },

        // familias
        {
            path: "/familias",
            name: "familias.index",
            component: require("./components/modulos/familias/index.vue")
                .default,
        },

        // sub_familias
        {
            path: "/sub_familias",
            name: "sub_familias.index",
            component: require("./components/modulos/sub_familias/index.vue")
                .default,
        },
        // gama_mantenimientos
        {
            path: "/gama_mantenimientos",
            name: "gama_mantenimientos.index",
            component:
                require("./components/modulos/gama_mantenimientos/index.vue")
                    .default,
        },
        {
            path: "/gama_mantenimientos/create",
            name: "gama_mantenimientos.create",
            component:
                require("./components/modulos/gama_mantenimientos/create.vue")
                    .default,
        },
        {
            path: "/gama_mantenimientos/:id",
            name: "gama_mantenimientos.edit",
            component:
                require("./components/modulos/gama_mantenimientos/edit.vue")
                    .default,
            props: true,
        },

        // plan_mantenimientos
        {
            path: "/plan_mantenimientos",
            name: "plan_mantenimientos.index",
            component:
                require("./components/modulos/plan_mantenimientos/index.vue")
                    .default,
        },
        {
            path: "/plan_mantenimientos/create",
            name: "plan_mantenimientos.create",
            component:
                require("./components/modulos/plan_mantenimientos/create.vue")
                    .default,
        },
        {
            path: "/plan_mantenimientos/:id",
            name: "plan_mantenimientos.edit",
            component:
                require("./components/modulos/plan_mantenimientos/edit.vue")
                    .default,
            props: true,
        },

        // orden_trabajos
        {
            path: "/orden_trabajos",
            name: "orden_trabajos.index",
            component: require("./components/modulos/orden_trabajos/index.vue")
                .default,
        },
        {
            path: "/orden_trabajos/programacion",
            name: "orden_trabajos.programacion",
            component:
                require("./components/modulos/orden_trabajos/programacion.vue")
                    .default,
        },
        {
            path: "/orden_trabajos/show/:id",
            name: "orden_trabajos.show",
            component: require("./components/modulos/orden_trabajos/show.vue")
                .default,
            props: true,
        },
        {
            path: "/orden_trabajos/consultar_ot",
            name: "orden_trabajos.consultar_ot",
            component:
                require("./components/modulos/orden_trabajos/consultar_ot.vue")
                    .default,
            props: true,
        },
        {
            path: "/orden_trabajos/consultar_ot/orden_trabajo/:id",
            name: "orden_trabajos.orden_trabajo",
            component:
                require("./components/modulos/orden_trabajos/orden_trabajo.vue")
                    .default,
            props: true,
        },

        // orden_generadas
        {
            path: "/orden_trabajos/generar_ots",
            name: "orden_trabajos.generar_ots",
            component:
                require("./components/modulos/orden_trabajos/generar_ots.vue")
                    .default,
        },

        // pedido_repuestos
        {
            path: "/pedido_repuestos",
            name: "pedido_repuestos.index",
            component:
                require("./components/modulos/pedido_repuestos/index.vue")
                    .default,
        },

        // notificacions
        {
            path: "/notificacions/:id",
            name: "notificacions.show",
            component: require("./components/modulos/notificacions/show.vue")
                .default,
            props: true,
        },

        // historial_tiempos
        {
            path: "/historial_tiempos",
            name: "historial_tiempos.index",
            component:
                require("./components/modulos/historial_tiempos/index.vue")
                    .default,
        },

        // Reportes
        {
            path: "/reportes/usuarios",
            name: "reportes.usuarios",
            component: require("./components/modulos/reportes/usuarios.vue")
                .default,
            props: true,
        },
        {
            path: "/reportes/kardex_herramientas",
            name: "reportes.kardex_herramientas",
            component:
                require("./components/modulos/reportes/kardex_herramientas.vue")
                    .default,
            props: true,
        },
        {
            path: "/reportes/informacion_herramientas",
            name: "reportes.informacion_herramientas",
            component:
                require("./components/modulos/reportes/informacion_herramientas.vue")
                    .default,
            props: true,
        },

        // PÁGINA NO ENCONTRADA
        {
            path: "*",
            component: require("./components/modulos/errors/404.vue").default,
        },
    ],
    mode: "history",
    linkActiveClass: "active open",
});
