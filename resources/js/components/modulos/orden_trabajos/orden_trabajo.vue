<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Orden de Trabajo</h1>
                    </div>
                </div>
            </div>
        </section>
        <section class="content">
            <div class="container-fluid">
                <div class="row pl-1 pr-1">
                    <div class="col-md-2 pl-0 pr-0">
                        <router-link
                            :to="{
                                name: 'orden_trabajos.index',
                            }"
                            v-if="permisos.includes('orden_trabajos.index')"
                            class="btn btn-info btn-flat btn-block border-white"
                        >
                            <i class="fa fa-arrow-left"></i>
                            Ordenes de trabajo
                        </router-link>
                    </div>
                    <div class="col-md-2 pl-0 pr-0">
                        <router-link
                            v-if="permisos.includes('orden_trabajos.index')"
                            :to="{ name: 'orden_trabajos.programacion' }"
                            class="btn btn-primary btn-flat btn-block border-white"
                        >
                            <i class="fa fa-list-alt"></i>
                            Programación
                        </router-link>
                    </div>
                    <div class="col-md-2 pl-0 pr-0">
                        <router-link
                            v-if="permisos.includes('orden_generadas.consultar_ot')"
                            :to="{
                                name: 'orden_trabajos.consultar_ot',
                            }"
                            class="btn btn-primary btn-flat btn-block border-white"
                        >
                            <i class="fa fa-list"></i>
                            Consultar OT's
                        </router-link>
                    </div>
                    <div class="col-md-2 pl-0 pr-0">
                        <router-link
                            v-if="permisos.includes('orden_generadas.index')"
                            :to="{
                                name: 'orden_trabajos.generar_ots',
                            }"
                            class="btn btn-primary btn-flat btn-block border-white"
                        >
                            <i class="fa fa-list"></i>
                            Generar OT
                        </router-link>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title">
                                    Visualizar Orden de Trabajo
                                </h3>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <p class="text-md">
                                        <strong>NÚMERO DE OT: </strong>
                                        {{ oOrdenTrabajo.id }}
                                    </p>
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <th>Área</th>
                                                <th>Sistema</th>
                                                <th>Subunidad</th>
                                                <th>Equipo</th>
                                                <th>Descripción</th>
                                                <th>Prioridad</th>
                                                <th>Tiempo estimado</th>
                                                <th>Fecha límite</th>
                                                <th>Tipo de mantenimiento</th>
                                            </tr>
                                        </thead>
                                        <tbody v-if="oOrdenTrabajo != 0">
                                            <tr>
                                                <td>
                                                    {{
                                                        oOrdenTrabajo.subunidad
                                                            ?.area.nombre
                                                    }}
                                                </td>
                                                <td>
                                                    {{
                                                        oOrdenTrabajo.subunidad
                                                            ?.sistema.nombre
                                                    }}
                                                </td>
                                                <td>
                                                    {{
                                                        oOrdenTrabajo.subunidad
                                                            ?.codigo
                                                    }}
                                                </td>
                                                <td>
                                                    {{
                                                        oOrdenTrabajo.gama
                                                            ?.equipo.full_name
                                                    }}
                                                </td>
                                                <td>
                                                    {{
                                                        oOrdenTrabajo.gama
                                                            ?.descripcion
                                                    }}
                                                </td>
                                                <td>
                                                    {{
                                                        oOrdenTrabajo.prioridad
                                                    }}
                                                </td>
                                                <td>
                                                    {{ oOrdenTrabajo.tiempo }}
                                                </td>
                                                <td>
                                                    {{
                                                        oOrdenTrabajo.gama
                                                            ?.plan_mantenimiento
                                                            .fecha_final
                                                    }}
                                                </td>
                                                <td>
                                                    {{
                                                        oOrdenTrabajo.tipo_mantenimiento
                                                    }}
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <h4 class="text-md">Repuestos</h4>
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <td>Código</td>
                                                <td>Nombre</td>
                                                <td>Cantidad</td>
                                                <td>Cantidad utilizada</td>
                                                <td>Cantidad saldo</td>
                                            </tr>
                                        </thead>
                                        <tbody v-if="oOrdenTrabajo != 0">
                                            <tr
                                                v-for="(
                                                    item, index
                                                ) in oOrdenTrabajo
                                                    .orden_generada
                                                    ?.detalle_repuestos"
                                                :class="{
                                                    actualizado:
                                                        item.actualizado,
                                                }"
                                            >
                                                <td>
                                                    {{ item.repuesto.codigo }}
                                                </td>
                                                <td>
                                                    {{ item.repuesto.nombre }}
                                                </td>
                                                <td>
                                                    {{
                                                        item.cantidad_requerida
                                                    }}
                                                </td>
                                                <td>
                                                    {{
                                                        item.repuesto
                                                            .cantidad_utilizada
                                                    }}
                                                </td>
                                                <td>
                                                    {{
                                                        item.repuesto
                                                            .stock_actual
                                                    }}
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <h4 class="text-md">Herramientas</h4>
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <td>Código</td>
                                                <td>Nombre</td>
                                                <td>Cantidad</td>
                                            </tr>
                                        </thead>
                                        <tbody v-if="oOrdenTrabajo != 0">
                                            <tr
                                                v-for="(
                                                    item, index
                                                ) in oOrdenTrabajo
                                                    .orden_generada
                                                    ?.detalle_herramientas"
                                                :class="{
                                                    actualizado:
                                                        item.actualizado,
                                                }"
                                            >
                                                <td>
                                                    {{
                                                        item.herramienta.codigo
                                                    }}
                                                </td>
                                                <td>
                                                    {{
                                                        item.herramienta.nombre
                                                    }}
                                                </td>
                                                <td>
                                                    {{
                                                        item.cantidad_solicitada
                                                    }}
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <h4 class="text-md">Mantenimiento</h4>
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <td>N°</td>
                                                <td>Tarea</td>
                                            </tr>
                                        </thead>
                                        <tbody v-if="oOrdenTrabajo != 0">
                                            <tr
                                                v-for="(
                                                    item, index
                                                ) in oOrdenTrabajo.gama
                                                    ?.gama_detalles"
                                                :class="{
                                                    actualizado:
                                                        item.actualizado,
                                                }"
                                            >
                                                <td>{{ index + 1 }}</td>
                                                <td>
                                                    {{ item.tarea }}
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <h4 class="text-md">Personal</h4>
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <td>N°</td>
                                                <td>Especialidad</td>
                                                <td>Nombre</td>
                                            </tr>
                                        </thead>
                                        <tbody v-if="oOrdenTrabajo != 0">
                                            <tr
                                                v-for="(
                                                    item, index
                                                ) in oOrdenTrabajo
                                                    .orden_generada
                                                    ?.detalle_personals"
                                                :class="{
                                                    actualizado:
                                                        item.actualizado,
                                                }"
                                            >
                                                <td>{{ index + 1 }}</td>
                                                <td>
                                                    {{
                                                        item.personal
                                                            .especialidad
                                                    }}
                                                </td>
                                                <td>
                                                    {{
                                                        item.personal
                                                            .razon_social
                                                    }}
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <h4 class="text-md">Documentación</h4>
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <td>Descripción</td>
                                                <td>Archivo</td>
                                            </tr>
                                        </thead>
                                        <tbody v-if="oOrdenTrabajo != 0">
                                            <tr>
                                                <td>
                                                    {{
                                                        oOrdenTrabajo
                                                            .orden_generada
                                                            ?.descripcion
                                                    }}
                                                </td>
                                                <td>
                                                    <a
                                                        :href="
                                                            oOrdenTrabajo
                                                                .orden_generada
                                                                ?.url_archivo
                                                        "
                                                        target="_blank"
                                                        >Descargar</a
                                                    >
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <h4 class="text-md">Comentario/Nota</h4>
                                    <table class="table table-bordered">
                                        <tbody v-if="oOrdenTrabajo != 0">
                                            <tr>
                                                <td>
                                                    {{
                                                        oOrdenTrabajo
                                                            .orden_generada
                                                            ?.comentario
                                                    }}
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <p class="text-md">
                                            <strong>ESTADO ACTUAL: </strong
                                            >{{ oOrdenTrabajo.estado }}
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</template>

<script>
export default {
    props: ["id"],
    data() {
        return {
            permisos: localStorage.getItem("permisos"),
            loadingWindow: Loading.service({
                fullscreen: this.fullscreenLoading,
            }),
            oOrdenTrabajo: {
                id: 0,
            },
            errors: [],
        };
    },
    mounted() {
        this.loadingWindow.close();
        this.getOrdenTrabajo();
    },
    methods: {
        getOrdenTrabajo() {
            axios("/admin/orden_trabajos/" + this.id).then((response) => {
                this.oOrdenTrabajo = response.data.orden_trabajo;
            });
        },
    },
};
</script>

<style>
.actualizado {
    background-color: rgb(91, 255, 170);
}
</style>
