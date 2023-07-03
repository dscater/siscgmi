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
                    <div class="row">
                        <p class="col-md-12">
                            <strong>Fecha de programación: </strong
                            >{{ orden_trabajo.fecha_programada }}
                        </p>
                        <p class="col-md-12">
                            <strong>Fecha y hora de inicio: </strong
                            >{{ orden_trabajo.fecha_inicio }}
                            {{ orden_trabajo.hora_inicio }}
                        </p>
                        <p class="col-md-12">
                            <strong>Fecha y hora de termino: </strong
                            >{{ fecha }} {{ hora }}
                        </p>
                        <p class="col-md-12">
                            <strong>Tiempo estimado (minutos): </strong
                            >{{ orden_trabajo.gama?.tiempo_total }}
                        </p>
                        <p class="col-md-12">
                            <strong>Tiempo de ejecución (horas): </strong>
                            <span v-text="form.tiempo_ejecucion"></span>
                        </p>
                    </div>
                    <form v-if="form">
                        <div class="row">
                            <div class="form-group col-md-12">
                                <label
                                    :class="{
                                        'text-danger': errors.parada_maquina,
                                    }"
                                    >Parada de máquina*</label
                                >
                                <el-select
                                    class="w-100"
                                    :class="{
                                        'is-invalid': errors.parada_maquina,
                                    }"
                                    v-model="form.parada_maquina"
                                >
                                    <el-option
                                        v-for="(item, index) in ['SI', 'NO']"
                                        :key="index"
                                        :value="item"
                                        :label="item"
                                    ></el-option>
                                </el-select>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.parada_maquina"
                                    v-text="errors.parada_maquina[0]"
                                ></span>
                            </div>
                        </div>
                        <div class="row" v-if="form.parada_maquina == 'SI'">
                            <div class="form-group col-md-12">
                                <label
                                    :class="{
                                        'text-danger': errors.tipo_falla,
                                    }"
                                    >Tipo de falla*</label
                                >
                                <el-select
                                    class="w-100"
                                    :class="{
                                        'is-invalid': errors.tipo_falla,
                                    }"
                                    v-model="form.tipo_falla"
                                    filterable
                                >
                                    <el-option
                                        v-for="(item, index) in listFallas"
                                        :key="index"
                                        :value="item"
                                        :label="item"
                                    ></el-option>
                                </el-select>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.tipo_falla"
                                    v-text="errors.tipo_falla[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-12">
                                <label
                                    :class="{
                                        'text-danger': errors.descripcion_falla,
                                    }"
                                    >Descripción de falla</label
                                >
                                <el-input
                                    type="textarea"
                                    autosize
                                    :class="{
                                        'is-invalid': errors.descripcion_falla,
                                    }"
                                    v-model="form.descripcion_falla"
                                >
                                </el-input>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.descripcion_falla"
                                    v-text="errors.descripcion_falla[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.fecha_falla,
                                    }"
                                    >Fecha de falla*</label
                                >
                                <input
                                    type="date"
                                    class="form-control"
                                    :class="{
                                        'is-invalid': errors.fecha_falla,
                                    }"
                                    v-model="form.fecha_falla"
                                    @change="getTiempoFalla"
                                    @keyup="getTiempoFalla"
                                />
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.fecha_falla"
                                    v-text="errors.fecha_falla[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.hora_falla,
                                    }"
                                    >Hora de falla*</label
                                >
                                <input
                                    type="time"
                                    class="form-control"
                                    :class="{
                                        'is-invalid': errors.hora_falla,
                                    }"
                                    v-model="form.hora_falla"
                                    @change="getTiempoFalla"
                                    @keyup="getTiempoFalla"
                                />
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.hora_falla"
                                    v-text="errors.hora_falla[0]"
                                ></span>
                            </div>

                            <div class="form-group col-md-12">
                                <p class="mb-1">
                                    <strong>Tiempo falla (minutos):</strong>
                                    <span v-text="form.tiempo_falla"></span>
                                </p>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.tiempo_falla"
                                    v-text="errors.tiempo_falla[0]"
                                ></span>
                            </div>
                        </div>
                        <hr class="col-md-12 pl-0" />
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
                this.fecha = this.getFeachaActual();
                this.hora = this.getHoraActual();
                let self = this;
                setTimeout(self.getTiempoEjecucion, 500);
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
            return "TERMINAR OT: " + this.orden_trabajo.id;
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
            listFallas: [
                "MECÁNICA",
                "ELÉCTRICA",
                "HIDRÁULICA",
                "NEUMÁTICA",
                "OPERATIVA",
                "LUBRICACIÓN",
                "DESGASTE",
                "CALIBRACIÓN",
                "SUMINISTRO",
                "SEGURIDAD",
                "SOFTWARE",
            ],
            form: {
                parada_maquina: "",
                tiempo_ejecucion: 0,
                tipo_falla: "",
                descripcion_falla: "",
                razon: "",
                comentario: "",
                fecha_falla: "",
                hora_falla: "",
                tiempo_falla: "",
                estado: this.nuevo_estado,
            },
            fecha: "",
            hora: "",
        };
    },
    mounted() {
        this.bModal = this.muestra_modal;
    },
    methods: {
        getTiempoEjecucion() {
            axios
                .get("/admin/orden_trabajos/getTiempoEjecucion", {
                    params: {
                        fecha_ini: `${this.orden_trabajo.fecha_inicio} ${this.orden_trabajo.hora_inicio}`,
                        fecha_fin: `${this.fecha} ${this.hora}`,
                    },
                })
                .then((response) => {
                    console.log(response.data);
                    this.form.tiempo_ejecucion = response.data.horas;
                });
        },
        getTiempoFalla() {
            if (
                this.fecha != "" &&
                this.hora != "" &&
                this.form.fecha_falla != "" &&
                this.form.hora_falla
            ) {
                axios
                    .get("/admin/orden_trabajos/getTiempoEjecucion", {
                        params: {
                            fecha_ini: `${this.fecha} ${this.hora}`,
                            fecha_fin: `${this.form.fecha_falla} ${this.form.hora_falla}`,
                        },
                    })
                    .then((response) => {
                        console.log(response.data);
                        this.form.tiempo_falla = response.data.minutos;
                    });
            } else {
                this.form.tiempo_falla = "";
            }
        },
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
                if (
                    this.form.fecha_falla &&
                    this.form.fecha_falla.trim() != ""
                ) {
                    formdata.append("fecha_falla", this.form.fecha_falla);
                }
                if (this.form.hora_falla && this.form.hora_falla.trim() != "") {
                    formdata.append("hora_falla", this.form.hora_falla);
                }
                if (this.form.tiempo_falla) {
                    formdata.append("tiempo_falla", this.form.tiempo_falla);
                }

                formdata.append("fecha_termino", this.fecha);
                formdata.append("hora_termino", this.hora);

                if (this.form.tiempo_ejecucion) {
                    formdata.append(
                        "tiempo_ejecucion",
                        this.form.tiempo_ejecucion
                    );
                }
                if (
                    this.form.parada_maquina &&
                    this.form.parada_maquina.trim() != ""
                ) {
                    formdata.append("parada_maquina", this.form.parada_maquina);
                }
                if (this.form.parada_maquina == "SI") {
                    if (
                        this.form.tipo_falla &&
                        this.form.tipo_falla.trim() != ""
                    ) {
                        formdata.append("tipo_falla", this.form.tipo_falla);
                    }
                    if (
                        this.form.descripcion_falla &&
                        this.form.descripcion_falla.trim() != ""
                    ) {
                        formdata.append(
                            "descripcion_falla",
                            this.form.descripcion_falla
                        );
                    }
                }

                let url =
                    "/admin/orden_trabajos/registraTerminarOT/" +
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
