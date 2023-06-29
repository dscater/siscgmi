<template>
    <div
        class="modal fade"
        :class="{ show: bModal }"
        id="modal-default"
        aria-modal="true"
        role="dialog"
    >
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <h4 class="modal-title" v-text="tituloModal"></h4>
                    <button
                        type="button"
                        class="close"
                        data-dismiss="modal"
                        aria-label="Close"
                        @click="cierraModal"
                    >
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="row">
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.fecha_programada,
                                    }"
                                    >Fecha programda*</label
                                >
                                <input
                                    type="date"
                                    class="form-control"
                                    :class="{
                                        'is-invalid': errors.fecha_programada,
                                    }"
                                    v-model="orden_trabajo.fecha_programada"
                                />
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.fecha_programada"
                                    v-text="errors.fecha_programada[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.hora_programada,
                                    }"
                                    >Hora programda*</label
                                >
                                <input
                                    type="time"
                                    class="form-control"
                                    :class="{
                                        'is-invalid': errors.hora_programada,
                                    }"
                                    v-model="orden_trabajo.hora_programada"
                                />
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.hora_programada"
                                    v-text="errors.hora_programada[0]"
                                ></span>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer justify-content-between">
                    <button
                        type="button"
                        class="btn btn-default"
                        data-dismiss="modal"
                        @click="cierraModal"
                    >
                        Cerrar
                    </button>
                    <el-button
                        type="primary"
                        class="bg-primary"
                        :loading="enviando"
                        @click="setRegistroModal()"
                        >{{ textoBoton }}</el-button
                    >
                </div>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    props: {
        muestra_modal: {
            type: Boolean,
            default: false,
        },
        accion: {
            type: String,
            default: "nuevo",
        },
        orden_trabajo: {
            type: Object,
            default: {
                id: 0,
                fecha_programada: "",
                hora_programada: "",
                subunidad_id: "",
                gama_id: "",
                prioridad: "",
                tiempo: "",
                dias: "",
                tipo_mantenimiento: "",
                fecha_inicio: "",
                hora_inicio: "",
                fecha_termino: "",
                hora_termino: "",
                tiempo_ejecucion: "",
                parada_maquina: "",
                estado: "",
                razon: "",
                comentario: "",
            },
        },
    },
    watch: {
        muestra_modal: function (newVal, oldVal) {
            this.errors = [];
            if (newVal) {
                this.bModal = true;
            } else {
                this.bModal = false;
            }
        },
    },
    computed: {
        tituloModal() {
            if (this.accion == "nuevo") {
                return "NUEVO REGISTRO";
            } else {
                return "MODIFICAR FECHA Y HORA: " + this.orden_trabajo.id;
            }
        },
        textoBoton() {
            if (this.accion == "nuevo") {
                return "Registrar";
            } else {
                return "Actualizar";
            }
        },
    },
    data() {
        return {
            user: JSON.parse(localStorage.getItem("user")),
            bModal: this.muestra_modal,
            enviando: false,
            errors: [],
        };
    },
    mounted() {
        this.bModal = this.muestra_modal;
    },
    methods: {
        setRegistroModal() {
            let fecha_actual = this.$moment();
            let fecha_nueva = this.$moment(
                this.orden_trabajo.fecha_programada,
                "YYYY-MM-DD"
            );
            if (!fecha_nueva.isBefore(fecha_actual)) {
                axios
                    .post(
                        "/admin/orden_trabajos/actualiza_fecha/" +
                            this.orden_trabajo.id,
                        {
                            _method: "put",
                            fecha_programada:
                                this.orden_trabajo.fecha_programada,
                            hora_programada: this.orden_trabajo.hora_programada,
                        }
                    )
                    .then((response) => {
                        Swal.fire({
                            icon: "success",
                            title: response.data.msj,
                            showConfirmButton: false,
                            timer: 1500,
                        });
                        this.$emit("envioModal");
                    });
            } else {
                Swal.fire({
                    icon: "error",
                    title: "No es posible reasignar una orden de trabajo hacia una fecha pasada",
                    showConfirmButton: false,
                    timer: 1500,
                });
            }
        },
        // Dialog/modal
        cierraModal() {
            this.bModal = false;
            this.$emit("close");
        },
        limpiaOrdenTrabajo() {
            this.errors = [];
            this.orden_trabajo.codigo = "";
            this.orden_trabajo.nombre = "";
        },
    },
};
</script>

<style></style>
