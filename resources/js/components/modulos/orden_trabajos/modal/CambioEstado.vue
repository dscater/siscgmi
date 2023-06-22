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
                    <form v-if="form">
                        <div class="row">
                            <div class="form-group col-md-12">
                                <label
                                    :class="{
                                        'text-danger': errors.razon,
                                    }"
                                    >Razón de Cambio de Estado*</label
                                >
                                <el-input
                                    type="textarea"
                                    autosize
                                    :class="{
                                        'is-invalid': errors.razon,
                                    }"
                                    v-model="form.razon"
                                >
                                </el-input>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.razon"
                                    v-text="errors.razon[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-12">
                                <label
                                    :class="{
                                        'text-danger': errors.comentario,
                                    }"
                                    >Comentario</label
                                >
                                <el-input
                                    type="textarea"
                                    autosize
                                    :class="{
                                        'is-invalid': errors.comentario,
                                    }"
                                    v-model="form.comentario"
                                >
                                </el-input>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.comentario"
                                    v-text="errors.comentario[0]"
                                ></span>
                            </div>
                        </div>
                    </form>
                    <div class="row" v-if="form.estado == 'INICIADO'">
                        <div class="col-md">
                            <p><strong>Fecha de inicio: </strong>{{ fecha }}</p>
                            <p><strong>Hora de inicio: </strong>{{ hora }}</p>
                        </div>
                    </div>
                </div>
                <div class="modal-footer justify-content-between">
                    <button
                        type="button"
                        class="btn btn-default"
                        data-dismiss="modal"
                        @click="cierraModal"
                    >
                        Cancelar
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
                    comentario_documentacion: "",
                    comentario: "",
                    detalle_documentacions: [],
                    detalle_documentacions: [],
                    detalle_documentacions: [],
                },
            },
        },
        nuevo_estado: { type: String, default: "" },
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
        nuevo_estado(newVal) {
            this.form.estado = newVal;
        },
    },
    computed: {
        tituloModal() {
            return "CONFIRMAR CAMBIO DE ESTADO: " + this.form.estado;
        },
        textoBoton() {
            return "Guardar cambios";
        },
    },
    data() {
        return {
            user: JSON.parse(localStorage.getItem("user")),
            bModal: this.muestra_modal,
            enviando: false,
            errors: [],
            form: {
                razon: "",
                comentario: "",
                estado: this.nuevo_estado,
            },
            fecha: "",
            hora: "",
        };
    },
    mounted() {
        this.bModal = this.muestra_modal;
        this.fecha = this.getFeachaActual();
        this.hora = this.getHoraActual();
    },
    methods: {
        setRegistroModal() {
            this.enviando = true;
            try {
                this.textoBtn = "Enviando...";
                let config = {
                    headers: {
                        "Content-Type": "multipart/form-data",
                    },
                };
                let formdata = new FormData();
                if (this.form.razon && this.form.razon.trim() != "") {
                    formdata.append("razon", this.form.razon);
                }
                if (this.form.comentario && this.form.comentario.trim() != "") {
                    formdata.append("comentario", this.form.comentario);
                }
                if (this.form.estado && this.form.estado.trim() != "") {
                    formdata.append("estado", this.form.estado);
                }
                if (this.form.estado == "INICIADO") {
                    formdata.append("fecha_inicio", this.fecha);
                    formdata.append("hora_inicio", this.hora);
                }

                let url =
                    "/admin/orden_trabajos/registraNuevoEstado/" +
                    this.orden_trabajo.id;
                axios
                    .post(url, formdata, config)
                    .then((response) => {
                        this.enviando = false;
                        if (response.data.sw) {
                            Swal.fire({
                                icon: "success",
                                title: response.data.message,
                                showConfirmButton: false,
                                timer: 1500,
                            });
                            this.$emit("envioModal", this.form.estado);
                            this.limpiaModal();
                        } else {
                            Swal.fire({
                                icon: "info",
                                title: "Atención",
                                html: response.data.message,
                                showConfirmButton: false,
                                timer: 2000,
                            });
                        }
                    })
                    .catch((error) => {
                        this.enviando = false;
                        if (this.accion == "edit") {
                            this.textoBtn = "Actualizar";
                        } else {
                            this.textoBtn = "Registrar";
                        }
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
            } catch (e) {
                this.enviando = false;
                console.log(e);
            }
        },
        // Dialog/modal
        cierraModal() {
            this.bModal = false;
            this.$emit("close");
        },
        limpiaModal() {
            this.errors = [];
            this.form.razon = "";
            this.form.comentario = "";
            this.form.estado = "";
        },
    },
};
</script>

<style></style>
