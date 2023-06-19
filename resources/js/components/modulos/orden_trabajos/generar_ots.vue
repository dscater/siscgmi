<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Ordenes de Trabajo - Generar OT's</h1>
                    </div>
                </div>
            </div>
        </section>
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-3">
                        <router-link
                            :to="{
                                name: 'orden_trabajos.index',
                            }"
                            v-if="permisos.includes('orden_trabajos.index')"
                            class="btn btn-info btn-flat btn-block"
                        >
                            <i class="fa fa-arrow-left"></i>
                            Volver a Ordenes de trabajo
                        </router-link>
                    </div>
                    <div class="col-md-3">
                        <router-link
                            v-if="permisos.includes('orden_trabajos.index')"
                            :to="{
                                name: 'orden_trabajos.programacion',
                            }"
                            class="btn btn-primary btn-flat btn-block"
                        >
                            <i class="fa fa-list-alt"></i>
                            Programación
                        </router-link>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-body pb-0 pt-2">
                                <div class="row">
                                    <div class="col-md-8 m-auto">
                                        <div class="row">
                                            <div class="col-md-6 form-group">
                                                <label>Fecha inicio:</label>
                                                <input
                                                    type="date"
                                                    class="form-control"
                                                    v-model="fecha_ini"
                                                    @change="getOrdenTrabajos"
                                                    @keyup="getOrdenTrabajos"
                                                />
                                            </div>
                                            <div class="col-md-6 form-group">
                                                <label>Fecha fin:</label>
                                                <input
                                                    type="date"
                                                    class="form-control"
                                                    v-model="fecha_fin"
                                                    @change="getOrdenTrabajos"
                                                    @keyup="getOrdenTrabajos"
                                                />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-3" v-for="item in listOrdenTrabajos">
                        <div class="card">
                            <div class="card-body pb-1">
                                <p><strong>Código OT:</strong> {{ item.id }}</p>
                                <p>
                                    <strong>Código de Mantenimiento:</strong>
                                    {{ item.gama.codigo }}
                                </p>
                                <p>
                                    <strong>Descripción:</strong>
                                    {{ item.gama.descripcion }}
                                </p>
                                <p>
                                    <strong>Programación:</strong>
                                    {{ item.fecha_programada }}
                                </p>
                                <p>
                                    <strong>Código de Equipo:</strong>
                                    {{ item.gama.equipo.codigo }}
                                </p>
                                <p class="mb-0">
                                    <strong>Código de Subunidad:</strong>
                                    {{ item.subunidad.codigo }}
                                </p>
                            </div>
                            <div class="card-footer pt-1">
                                <div class="row">
                                    <div class="col-md-12">
                                        <button
                                            class="btn btn-primary btn-flat btn-block mt-1"
                                            @click="registraRepuestos(item)"
                                        >
                                            Repuestos ({{
                                                item.orden_generada
                                                    ?.detalle_repuestos
                                                    ? item.orden_generada
                                                          ?.detalle_repuestos
                                                          .length
                                                    : 0
                                            }})
                                        </button>
                                    </div>
                                    <div class="col-md-12">
                                        <button
                                            class="btn btn-primary btn-flat btn-block mt-1"
                                            @click="registraHerramientas(item)"
                                        >
                                            Herramientas ({{
                                                item.orden_generada
                                                    ?.detalle_herramientas
                                                    ? item.orden_generada
                                                          ?.detalle_herramientas
                                                          .length
                                                    : 0
                                            }})
                                        </button>
                                    </div>
                                    <div class="col-md-12">
                                        <button
                                            class="btn btn-primary btn-flat btn-block mt-1"
                                            @click="registraPersonal(item)"
                                        >
                                            Personal ({{
                                                item.orden_generada
                                                    ?.detalle_personals
                                                    ? item.orden_generada
                                                          ?.detalle_personals
                                                          .length
                                                    : 0
                                            }})
                                        </button>
                                    </div>
                                    <div class="col-md-12">
                                        <button
                                            class="btn btn-primary btn-flat btn-block mt-1"
                                            :disabled="
                                                item.orden_generada == null ||
                                                item.orden_generada
                                                    .detalle_herramientas
                                                    .length <= 0 ||
                                                item.orden_generada
                                                    .detalle_repuestos.length <=
                                                    0 ||
                                                item.orden_generada
                                                    .detalle_personals.length <=
                                                    0
                                            "
                                            @click="registraDocumentacion(item)"
                                        >
                                            Documentación
                                            <span
                                                v-if="
                                                    item.orden_generada
                                                        .url_archivo
                                                "
                                                ><i class="fa fa-check"></i
                                            ></span>
                                        </button>
                                    </div>
                                    <div class="col-md-12">
                                        <button
                                            class="btn btn-primary btn-flat btn-block mt-1"
                                            :disabled="
                                                item.orden_generada == null ||
                                                item.orden_generada
                                                    .detalle_herramientas
                                                    .length <= 0 ||
                                                item.orden_generada
                                                    .detalle_repuestos.length <=
                                                    0 ||
                                                item.orden_generada
                                                    .detalle_personals.length <=
                                                    0
                                            "
                                            @click="registraComentarios(item)"
                                        >
                                            Comentarios/Notas
                                            <span
                                                v-if="
                                                    item.orden_generada.comentario?.trim()
                                                "
                                                ><i class="fa fa-check"></i
                                            ></span>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <Repuestos
            :muestra_modal="modal_repuestos"
            :orden_trabajo="oOrdenTrabajo"
            @close="modal_repuestos = false"
            @envioModal="actualizaOrdenGenerada"
        ></Repuestos>
        <Herramientas
            :muestra_modal="modal_herramientas"
            :orden_trabajo="oOrdenTrabajo"
            @close="modal_herramientas = false"
            @envioModal="actualizaOrdenGenerada"
        ></Herramientas>
        <Personal
            :muestra_modal="modal_personal"
            :orden_trabajo="oOrdenTrabajo"
            @close="modal_personal = false"
            @envioModal="actualizaOrdenGenerada"
        ></Personal>
        <Documentacion
            :muestra_modal="modal_documentacion"
            :orden_trabajo="oOrdenTrabajo"
            @close="modal_documentacion = false"
            @envioModal="actualizaOrdenGenerada"
        ></Documentacion>
        <Comentarios
            :muestra_modal="modal_comentarios"
            :orden_trabajo="oOrdenTrabajo"
            @close="modal_comentarios = false"
            @envioModal="actualizaOrdenGenerada"
        ></Comentarios>
    </div>
</template>

<script>
import Repuestos from "./modal/Repuestos.vue";
import Herramientas from "./modal/Herramientas.vue";
import Personal from "./modal/Personal.vue";
import Documentacion from "./modal/Documentacion.vue";
import Comentarios from "./modal/Comentarios.vue";
export default {
    components: {
        Repuestos,
        Herramientas,
        Personal,
        Documentacion,
        Comentarios,
    },
    data() {
        return {
            permisos: localStorage.getItem("permisos"),
            loadingWindow: Loading.service({
                fullscreen: this.fullscreenLoading,
            }),
            fecha_ini: "",
            fecha_fin: "",
            listOrdenTrabajos: [],
            modal_repuestos: false,
            modal_herramientas: false,
            modal_personal: false,
            modal_documentacion: false,
            modal_comentarios: false,
            oOrdenTrabajo: {
                fecha_programada: "",
                subunidad_id: "",
                gama_id: "",
                prioridad: "",
                tiempo: "",
                dias: "",
                tipo_mantenimiento: "",
                estado: "",
                orden_generada: {
                    id: 0,
                    archivo: "",
                    descripcion_documentacion: "",
                    comentario: "",
                    detalle_repuestos: [],
                    detalle_herramientas: [],
                    detalle_personals: [],
                },
            },
        };
    },
    mounted() {
        this.loadingWindow.close();
        this.getOrdenTrabajos();
    },
    methods: {
        registraRepuestos(orden) {
            this.oOrdenTrabajo = orden;
            this.modal_repuestos = true;
        },
        registraHerramientas(orden) {
            this.oOrdenTrabajo = orden;
            this.modal_herramientas = true;
        },
        registraPersonal(orden) {
            this.oOrdenTrabajo = orden;
            this.modal_personal = true;
        },
        registraDocumentacion(orden) {
            this.oOrdenTrabajo = orden;
            this.modal_documentacion = true;
        },
        registraComentarios(orden) {
            this.oOrdenTrabajo = orden;
            this.modal_comentarios = true;
        },
        // Listar OrdenTrabajos
        getOrdenTrabajos() {
            this.showOverlay = true;
            this.muestra_modal = false;
            let url =
                "/admin/orden_trabajos/get/orden_trabajos/programados_fecha";
            let params = {};
            if (this.fecha_ini) {
                params["fecha_ini"] = this.fecha_ini;
            }
            if (this.fecha_fin) {
                params["fecha_fin"] = this.fecha_fin;
            }
            axios
                .get(url, {
                    params: params,
                })
                .then((res) => {
                    this.showOverlay = false;
                    this.listOrdenTrabajos = res.data;
                });
        },
        actualizaOrdenGenerada(orden_generada) {
            let index = this.listOrdenTrabajos.findIndex((elem) => {
                return elem.id === orden_generada.orden_id;
            });

            this.listOrdenTrabajos[index].orden_generada = {
                ...orden_generada,
            };
            this.modal_repuestos = false;
            this.modal_herramientas = false;
            this.modal_personal = false;
            this.modal_documentacion = false;
            this.modal_comentarios = false;
        },
    },
};
</script>

<style></style>
