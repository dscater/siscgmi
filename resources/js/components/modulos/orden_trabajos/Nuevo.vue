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
                                        'text-danger': errors.subunidad_id,
                                    }"
                                    >Seleccionar Subunidad*</label
                                >
                                <el-select
                                    placeholder="Seleccionar Subunidad"
                                    class="w-100"
                                    :class="{
                                        'is-invalid': errors.subunidad_id,
                                    }"
                                    v-model="orden_trabajo.subunidad_id"
                                    clearable
                                >
                                    <el-option
                                        v-for="item in listSubunidads"
                                        :key="item.id"
                                        :value="item.id"
                                        :label="
                                            item.full_name +
                                            ' | ' +
                                            item.equipo.codigo +
                                            ' | ' +
                                            item.equipo.nombre
                                        "
                                    ></el-option>
                                </el-select>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.subunidad_id"
                                    v-text="errors.subunidad_id[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.gama_id,
                                    }"
                                    >Seleccionar Gama de Mantenimiento*</label
                                >
                                <el-select
                                    placeholder="Seleccionar Gama de Mantenimiento"
                                    class="w-100"
                                    :class="{
                                        'is-invalid': errors.gama_id,
                                    }"
                                    v-model="orden_trabajo.gama_id"
                                    @change="getTiempoGama"
                                    clearable
                                >
                                    <el-option
                                        v-for="item in listGamaMantenimientos"
                                        :key="item.id"
                                        :value="item.id"
                                        :label="item.full_name"
                                    ></el-option>
                                </el-select>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.gama_id"
                                    v-text="errors.gama_id[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.prioridad,
                                    }"
                                    >Prioridad*</label
                                >
                                <el-select
                                    placeholder="Prioridad"
                                    class="w-100"
                                    :class="{
                                        'is-invalid': errors.prioridad,
                                    }"
                                    v-model="orden_trabajo.prioridad"
                                    clearable
                                >
                                    <el-option
                                        v-for="(item, index) in listPrioridads"
                                        :key="index"
                                        :value="item"
                                        :label="item"
                                    ></el-option>
                                </el-select>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.prioridad"
                                    v-text="errors.prioridad[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.tiempo,
                                    }"
                                    >Tiempo total*</label
                                >
                                <input
                                    placeholder="Tiempo total"
                                    type="number"
                                    class="form-control"
                                    :class="{
                                        'is-invalid': errors.tiempo,
                                    }"
                                    v-model="orden_trabajo.tiempo"
                                    clearable
                                    readonly
                                />
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.tiempo"
                                    v-text="errors.tiempo[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.dias,
                                    }"
                                    >Días estimados para terminar</label
                                >
                                <input
                                    placeholder="Días estimados para terminar"
                                    type="number"
                                    class="form-control"
                                    :class="{
                                        'is-invalid': errors.dias,
                                    }"
                                    v-model="orden_trabajo.dias"
                                    clearable
                                />
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.dias"
                                    v-text="errors.dias[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger':
                                            errors.tipo_mantenimiento,
                                    }"
                                    >Tipo de Mantenimiento*</label
                                >
                                <el-select
                                    placeholder="Tipo de Mantenimiento"
                                    class="w-100"
                                    :class="{
                                        'is-invalid': errors.tipo_mantenimiento,
                                    }"
                                    v-model="orden_trabajo.tipo_mantenimiento"
                                    clearable
                                >
                                    <el-option
                                        v-for="(
                                            item, index
                                        ) in listTipoMantenimientos"
                                        :key="index"
                                        :value="item"
                                        :label="item"
                                    ></el-option>
                                </el-select>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.tipo_mantenimiento"
                                    v-text="errors.tipo_mantenimiento[0]"
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
                subunidad_id: "",
                gama_id: "",
                prioridad: "",
                tiempo: "",
                dias: "",
                tipo_mantenimiento: "",
                estado: "",
            },
        },
    },
    watch: {
        muestra_modal: function (newVal, oldVal) {
            this.errors = [];
            if (newVal) {
                this.bModal = true;
                if (this.accion == "nuevo") {
                    this.orden_trabajo.fecha_programada =
                        this.getFeachaActual();
                }
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
                return "MODIFICAR REGISTRO";
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
            listSubunidads: [],
            listGamaMantenimientos: [],
            listPrioridads: ["URGENTE", "MODERADA", "LEVE"],
            listTipoMantenimientos: [
                "PREVENTIVO",
                "CORRECTIVO",
                "PREDICTIVO",
                "INSPECCIÓN",
                "LUBRICACIÓN",
            ],
        };
    },
    mounted() {
        this.bModal = this.muestra_modal;
        this.getSubunidads();
        this.getGamaMantenimientos();
    },
    methods: {
        getSubunidads() {
            axios.get("/admin/subunidads").then((response) => {
                this.listSubunidads = response.data.subunidads;
            });
        },
        getGamaMantenimientos() {
            axios.get("/admin/gama_mantenimientos").then((response) => {
                this.listGamaMantenimientos = response.data.gama_mantenimientos;
            });
        },
        getTiempoGama() {
            if (this.orden_trabajo.gama_id != "") {
                axios
                    .get(
                        "/admin/gama_mantenimientos/getTiempo/" +
                            this.orden_trabajo.gama_id
                    )
                    .then((response) => {
                        this.orden_trabajo.tiempo = response.data;
                    });
            } else {
                this.orden_trabajo.tiempo = "";
            }
        },

        setRegistroModal() {
            this.enviando = true;
            try {
                this.textoBtn = "Enviando...";
                let url = "/admin/orden_trabajos";
                let config = {
                    headers: {
                        "Content-Type": "multipart/form-data",
                    },
                };
                let formdata = new FormData();

                if (this.orden_trabajo.fecha_programada.trim() != "") {
                    formdata.append(
                        "fecha_programada",
                        this.orden_trabajo.fecha_programada
                    );
                }
                if (this.orden_trabajo.subunidad_id) {
                    formdata.append(
                        "subunidad_id",
                        this.orden_trabajo.subunidad_id
                    );
                }
                if (this.orden_trabajo.gama_id) {
                    formdata.append("gama_id", this.orden_trabajo.gama_id);
                }
                if (this.orden_trabajo.prioridad.trim() != "") {
                    formdata.append("prioridad", this.orden_trabajo.prioridad);
                }
                if (this.orden_trabajo.tiempo) {
                    formdata.append("tiempo", this.orden_trabajo.tiempo);
                }
                if (this.orden_trabajo.dias) {
                    formdata.append("dias", this.orden_trabajo.dias);
                }
                if (this.orden_trabajo.tipo_mantenimiento.trim() != "") {
                    formdata.append(
                        "tipo_mantenimiento",
                        this.orden_trabajo.tipo_mantenimiento
                    );
                }

                if (this.accion == "edit") {
                    url = "/admin/orden_trabajos/" + this.orden_trabajo.id;
                    formdata.append("_method", "PUT");
                }
                axios
                    .post(url, formdata, config)
                    .then((res) => {
                        this.enviando = false;
                        if (res.data.sw) {
                            Swal.fire({
                                icon: "success",
                                title: res.data.msj,
                                showConfirmButton: false,
                                timer: 1500,
                            });
                            this.limpiaOrdenTrabajo();
                            this.$emit("envioModal");
                            this.errors = [];
                            if (this.accion == "edit") {
                                this.textoBtn = "Actualizar";
                            } else {
                                this.textoBtn = "Registrar";
                            }
                        } else {
                            Swal.fire({
                                icon: "info",
                                title: "Atención",
                                html: res.data.msj,
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
        limpiaOrdenTrabajo() {
            this.errors = [];
            this.orden_trabajo.fecha_programada = "";
            this.orden_trabajo.subunidad_id = "";
            this.orden_trabajo.gama_id = "";
            this.orden_trabajo.prioridad = "";
            this.orden_trabajo.tiempo = "";
            this.orden_trabajo.dias = "";
            this.orden_trabajo.tipo_mantenimiento = "";
            this.orden_trabajo.estado = "";
        },
    },
};
</script>

<style></style>
