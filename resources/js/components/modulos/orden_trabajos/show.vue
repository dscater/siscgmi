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
                    <div class="col-md-2 pl-0 pr-0">
                        <router-link
                            v-if="permisos.includes('pedido_repuestos.index')"
                            :to="{
                                name: 'orden_trabajos.pedido_repuestos',
                            }"
                            class="btn btn-primary btn-flat btn-block border-white"
                        >
                            <i class="fas fa-tasks"></i>
                            Pedido de Repuestos
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
                                                <td width="60px">Acción</td>
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
                                                <td class="text-center">
                                                    <span v-if="item.enviando"
                                                        ><i
                                                            class="fa fa-spinner fa-spin text-lg"
                                                        ></i
                                                    ></span>
                                                    <div
                                                        v-else
                                                        class="icheck-primary d-inline"
                                                    >
                                                        <input
                                                            type="checkbox"
                                                            :true-value="1"
                                                            :false-value="0"
                                                            :id="
                                                                'check_r_' +
                                                                item.id
                                                            "
                                                            v-model="
                                                                item.chekado
                                                            "
                                                            :disabled="
                                                                item.disabled
                                                                    ? true
                                                                    : false
                                                            "
                                                            @change="
                                                                cambiaEstadoDetalles(
                                                                    index,
                                                                    'detalle_repuestos',
                                                                    item
                                                                )
                                                            "
                                                        />
                                                        <label
                                                            :for="
                                                                'check_r_' +
                                                                item.id
                                                            "
                                                        >
                                                        </label>
                                                    </div>
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
                                                <td width="60px">Acción</td>
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
                                                <td class="text-center">
                                                    <span v-if="item.enviando"
                                                        ><i
                                                            class="fa fa-spinner fa-spin text-lg"
                                                        ></i
                                                    ></span>
                                                    <div
                                                        v-else
                                                        class="icheck-primary d-inline"
                                                    >
                                                        <input
                                                            type="checkbox"
                                                            :true-value="1"
                                                            :false-value="0"
                                                            :id="
                                                                'check_h_' +
                                                                item.id
                                                            "
                                                            v-model="
                                                                item.chekado
                                                            "
                                                            @change="
                                                                cambiaEstadoDetalles(
                                                                    index,
                                                                    'detalle_herramientas',
                                                                    item
                                                                )
                                                            "
                                                        />
                                                        <label
                                                            :for="
                                                                'check_h_' +
                                                                item.id
                                                            "
                                                        >
                                                        </label>
                                                    </div>
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
                                                <td width="60px">Acción</td>
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
                                                <td class="text-center">
                                                    <span v-if="item.enviando"
                                                        ><i
                                                            class="fa fa-spinner fa-spin text-lg"
                                                        ></i
                                                    ></span>
                                                    <div
                                                        v-else
                                                        class="icheck-primary d-inline"
                                                    >
                                                        <input
                                                            type="checkbox"
                                                            :true-value="1"
                                                            :false-value="0"
                                                            :id="
                                                                'check_t_' +
                                                                item.id
                                                            "
                                                            v-model="
                                                                item.chekado
                                                            "
                                                            @change="
                                                                cambiaEstadoDetalles(
                                                                    index,
                                                                    'gama_detalles',
                                                                    item
                                                                )
                                                            "
                                                        />
                                                        <label
                                                            :for="
                                                                'check_t_' +
                                                                item.id
                                                            "
                                                        >
                                                        </label>
                                                    </div>
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
                                                <td width="60px">Acción</td>
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
                                                <td class="text-center">
                                                    <span v-if="item.enviando"
                                                        ><i
                                                            class="fa fa-spinner fa-spin text-lg"
                                                        ></i
                                                    ></span>
                                                    <div
                                                        v-else
                                                        class="icheck-primary d-inline"
                                                    >
                                                        <input
                                                            type="checkbox"
                                                            :true-value="1"
                                                            :false-value="0"
                                                            :id="
                                                                'check_p_' +
                                                                item.id
                                                            "
                                                            v-model="
                                                                item.chekado
                                                            "
                                                            @change="
                                                                cambiaEstadoDetalles(
                                                                    index,
                                                                    'detalle_personals',
                                                                    item
                                                                )
                                                            "
                                                        />
                                                        <label
                                                            :for="
                                                                'check_p_' +
                                                                item.id
                                                            "
                                                        >
                                                        </label>
                                                    </div>
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
                                <div
                                    class="row"
                                    v-if="oOrdenTrabajo?.estado != 'CANCELADO'"
                                >
                                    <div
                                        class="col-md-4"
                                        v-if="
                                            oOrdenTrabajo?.estado ==
                                            'PROGRAMADO'
                                        "
                                    >
                                        <button
                                            type="button"
                                            @click="
                                                actualizaEstadoOT(
                                                    'INICIAR OT',
                                                    'INICIADO'
                                                )
                                            "
                                            class="btn btn-primary btn-block"
                                        >
                                            INICIAR OT
                                        </button>
                                    </div>
                                    <div
                                        class="col-md-4"
                                        v-if="
                                            oOrdenTrabajo?.estado == 'INICIADO'
                                        "
                                    >
                                        <button
                                            type="button"
                                            @click="
                                                actualizaEstadoOT(
                                                    'TERMINAR OT',
                                                    'TERMINADO'
                                                )
                                            "
                                            class="btn btn-primary btn-block"
                                        >
                                            TERMINAR OT
                                        </button>
                                    </div>
                                    <div
                                        class="col-md-4"
                                        v-if="
                                            oOrdenTrabajo?.estado !=
                                                'TERMINADO' &&
                                            !oOrdenTrabajo?.estado?.includes(
                                                'PENDIENTE'
                                            )
                                        "
                                    >
                                        <button
                                            type="button"
                                            @click="
                                                actualizaEstadoOT(
                                                    'CANCELAR OT',
                                                    'CANCELADO'
                                                )
                                            "
                                            class="btn btn-primary btn-block"
                                        >
                                            CANCELAR OT
                                        </button>
                                    </div>
                                    <div
                                        class="col-md-4"
                                        v-if="
                                            oOrdenTrabajo?.estado == 'PENDIENTE'
                                        "
                                    >
                                        <button
                                            type="button"
                                            @click="
                                                actualizaEstadoOT(
                                                    'PENDIENTE TERMINADO',
                                                    'PENDIENTE TERMINADO'
                                                )
                                            "
                                            class="btn btn-primary btn-block"
                                        >
                                            PENDIENTE TERMINADO
                                        </button>
                                    </div>
                                    <div
                                        class="col-md-4"
                                        v-if="
                                            oOrdenTrabajo?.estado == 'PENDIENTE'
                                        "
                                    >
                                        <button
                                            type="button"
                                            @click="
                                                actualizaEstadoOT(
                                                    'PENDIENTE CANCELADO',
                                                    'PENDIENTE CANCELADO'
                                                )
                                            "
                                            class="btn btn-primary btn-block"
                                        >
                                            PENDIENTE CANCELADO
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <CambioEstado
            :muestra_modal="modal_cambio_estado"
            :orden_trabajo="oOrdenTrabajo"
            :nuevo_estado="nuevo_estado"
            @close="modal_cambio_estado = false"
            @envioModal="muestraNuevoEstado"
        ></CambioEstado>
        <TerminarOT
            :muestra_modal="modal_terminar_ot"
            :orden_trabajo="oOrdenTrabajo"
            :nuevo_estado="nuevo_estado"
            @close="modal_terminar_ot = false"
            @envioModal="muestraNuevoEstado"
        ></TerminarOT>
    </div>
</template>

<script>
import CambioEstado from "./modal/CambioEstado.vue";
import TerminarOT from "./modal/TerminarOT.vue";
export default {
    props: ["id"],
    components: {
        CambioEstado,
        TerminarOT,
    },
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
            modal_cambio_estado: false,
            modal_terminar_ot: false,
            nuevo_estado: "",
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
        cambiaEstadoDetalles(index, tabla, item) {
            this.actualizaEstadoItem(index, tabla, true);
            axios
                .post(`/admin/${tabla}/cambiaEstado/${item.id}`, {
                    chekado: item.chekado,
                })
                .then((response) => {
                    if (response.data.sw) {
                        item.actualizado = true;
                        this.actualizaEstadoItem(index, tabla, false);
                        setTimeout(() => {}, 1500);
                        if (tabla == "detalle_repuestos") {
                            this.asignaItemActualizado(
                                index,
                                tabla,
                                response.data.item
                            );
                        }
                    } else {
                        Swal.fire({
                            icon: "error",
                            title: "Error",
                            html: "No se pudo actualizar el registro, intenté mas tarde",
                            showConfirmButton: false,
                            timer: 2000,
                        });
                    }
                    // Swal.fire({
                    //     icon: "success",
                    //     title: res.data.message,
                    //     showConfirmButton: false,
                    //     timer: 2500,
                    // });
                })
                .catch((error) => {
                    this.actualizaEstadoItem(index, tabla, false);
                    if (error.response) {
                        if (error.response.status === 422) {
                            this.errors = error.response.data.errors;
                        }
                        if (
                            error.response.status === 420 ||
                            error.response.status === 419 ||
                            error.response.status === 401
                        ) {
                            window.location = "/";
                        }
                        if (error.response.status === 500) {
                            Swal.fire({
                                icon: "error",
                                title: "Error",
                                html: error.response.data.message,
                                showConfirmButton: false,
                                timer: 2000,
                            });
                        }
                    }
                });
        },
        actualizaEstadoOT(accion, estado) {
            this.nuevo_estado = estado;
            if (accion == "TERMINAR OT") {
                this.modal_terminar_ot = true;
            } else {
                this.modal_cambio_estado = true;
            }
        },
        actualizaEstadoItem(index, tabla, valor) {
            switch (tabla) {
                case "detalle_repuestos":
                    if (valor) {
                        this.oOrdenTrabajo.orden_generada.detalle_repuestos[
                            index
                        ].enviando = valor;
                        this.oOrdenTrabajo.orden_generada.detalle_repuestos[
                            index
                        ].actualizado = valor;
                    } else {
                        this.oOrdenTrabajo.orden_generada.detalle_repuestos[
                            index
                        ].enviando = false;
                        this.oOrdenTrabajo.orden_generada.detalle_repuestos[
                            index
                        ].actualizado = false;
                    }
                    break;
                case "detalle_herramientas":
                    if (valor) {
                        this.oOrdenTrabajo.orden_generada.detalle_herramientas[
                            index
                        ].enviando = valor;
                        this.oOrdenTrabajo.orden_generada.detalle_herramientas[
                            index
                        ].actualizado = valor;
                    } else {
                        this.oOrdenTrabajo.orden_generada.detalle_herramientas[
                            index
                        ].enviando = false;
                        this.oOrdenTrabajo.orden_generada.detalle_herramientas[
                            index
                        ].actualizado = false;
                    }
                    break;
                case "gama_detalles":
                    if (valor) {
                        this.oOrdenTrabajo.gama.gama_detalles[index].enviando =
                            valor;
                        this.oOrdenTrabajo.gama.gama_detalles[
                            index
                        ].actualizado = valor;
                    } else {
                        this.oOrdenTrabajo.gama.gama_detalles[
                            index
                        ].enviando = false;
                        this.oOrdenTrabajo.gama.gama_detalles[
                            index
                        ].actualizado = false;
                    }
                    break;
                case "detalle_personals":
                    if (valor) {
                        this.oOrdenTrabajo.orden_generada.detalle_personals[
                            index
                        ].enviando = valor;
                        this.oOrdenTrabajo.orden_generada.detalle_personals[
                            index
                        ].actualizado = valor;
                    } else {
                        this.oOrdenTrabajo.orden_generada.detalle_personals[
                            index
                        ].enviando = false;
                        this.oOrdenTrabajo.orden_generada.detalle_personals[
                            index
                        ].actualizado = false;
                    }
                    break;
            }
        },
        asignaItemActualizado(index, tabla, nuevoItem) {
            switch (tabla) {
                case "detalle_repuestos":
                    this.oOrdenTrabajo.orden_generada.detalle_repuestos[index] =
                        nuevoItem;
                    break;
                case "detalle_herramientas":
                    this.oOrdenTrabajo.orden_generada.detalle_herramientas[
                        index
                    ] = nuevoItem;
                    break;
                case "gama_detalles":
                    this.oOrdenTrabajo.gama.gama_detalles[index] = nuevoItem;
                    break;
                case "detalle_personals":
                    this.oOrdenTrabajo.orden_generada.detalle_personals[index] =
                        nuevoItem;
                    break;
            }
        },
        muestraNuevoEstado(estado) {
            this.modal_terminar_ot = false;
            this.modal_cambio_estado = false;
            this.oOrdenTrabajo.estado = estado;
        },
    },
};
</script>

<style>
.actualizado {
    background-color: rgb(91, 255, 170);
}
</style>
