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
                                        'text-danger': errors.area_id,
                                    }"
                                    >Seleccionar Área*</label
                                >
                                <el-select
                                    placeholder="Área"
                                    class="w-100"
                                    :class="{ 'is-invalid': errors.area_id }"
                                    v-model="subunidad.area_id"
                                    clearable
                                    @change="generarCodigo2"
                                >
                                    <el-option
                                        v-for="item in listAreas"
                                        :key="item.id"
                                        :value="item.id"
                                        :label="
                                            item.codigo + ' | ' + item.nombre
                                        "
                                    ></el-option>
                                </el-select>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.area_id"
                                    v-text="errors.area_id[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.sistema_id,
                                    }"
                                    >Seleccionar Sistema*</label
                                >
                                <el-select
                                    placeholder="Sistema"
                                    class="w-100"
                                    :class="{ 'is-invalid': errors.sistema_id }"
                                    v-model="subunidad.sistema_id"
                                    clearable
                                    @change="generarCodigo2"
                                >
                                    <el-option
                                        v-for="item in listSistemas"
                                        :key="item.id"
                                        :value="item.id"
                                        :label="
                                            item.codigo + ' | ' + item.nombre
                                        "
                                    ></el-option>
                                </el-select>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.sistema_id"
                                    v-text="errors.sistema_id[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.equipo_id,
                                    }"
                                    >Seleccionar Equipo*</label
                                >
                                <el-select
                                    placeholder="Equipo"
                                    class="w-100"
                                    :class="{ 'is-invalid': errors.equipo_id }"
                                    v-model="subunidad.equipo_id"
                                    clearable
                                    @change="generarCodigo2"
                                >
                                    <el-option
                                        v-for="item in listEquipos"
                                        :key="item.id"
                                        :value="item.id"
                                        :label="
                                            item.codigo + ' | ' + item.nombre
                                        "
                                    ></el-option>
                                </el-select>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.equipo_id"
                                    v-text="errors.equipo_id[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-3">
                                <label
                                    :class="{
                                        'text-danger': errors.codigo,
                                    }"
                                    >Código*</label
                                >
                                <el-input
                                    placeholder="Código"
                                    :class="{ 'is-invalid': errors.codigo }"
                                    v-model="subunidad.codigo"
                                    minlength="4"
                                    maxlength="4"
                                    show-word-limit
                                    clearable
                                    @change.native="generarCodigo2"
                                    @keyup.native="generarCodigo2"
                                >
                                </el-input>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.codigo"
                                    v-text="errors.codigo[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-3">
                                <label
                                    :class="{
                                        'text-danger': errors.numero,
                                    }"
                                    >Número*</label
                                >
                                <el-input
                                    placeholder="Número"
                                    :class="{ 'is-invalid': errors.numero }"
                                    v-model="subunidad.numero"
                                    minlength="2"
                                    maxlength="2"
                                    show-word-limit
                                    clearable
                                    @change.native="generarCodigo2"
                                    @keyup.native="generarCodigo2"
                                >
                                </el-input>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.numero"
                                    v-text="errors.numero[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-12">
                                <label
                                    :class="{
                                        'text-danger': errors.nombre,
                                    }"
                                    >Nombre*</label
                                >
                                <el-input
                                    placeholder="Nombre"
                                    :class="{ 'is-invalid': errors.nombre }"
                                    v-model="subunidad.nombre"
                                    clearable
                                >
                                </el-input>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.nombre"
                                    v-text="errors.nombre[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-9">
                                <label
                                    :class="{
                                        'text-danger': errors.codigo2,
                                    }"
                                    >Código 2*</label
                                >
                                <el-input
                                    placeholder="Código"
                                    :class="{ 'is-invalid': errors.codigo2 }"
                                    v-model="subunidad.codigo2"
                                    readonly
                                >
                                </el-input>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.codigo2"
                                    v-text="errors.codigo2[0]"
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
        subunidad: {
            type: Object,
            default: {
                id: 0,
                area_id: "",
                sistema_id: "",
                equipo_id: "",
                codigo: "",
                nombre: "",
                numero: "",
                codigo2: "",
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
            listAreas: [],
            listSistemas: [],
            listEquipos: [],
        };
    },
    mounted() {
        this.bModal = this.muestra_modal;
        this.getAreas();
        this.getSistemas();
        this.getEquipos();
    },
    methods: {
        getAreas() {
            axios.get("/admin/areas").then((response) => {
                this.listAreas = response.data.areas;
            });
        },
        getSistemas() {
            axios.get("/admin/sistemas").then((response) => {
                this.listSistemas = response.data.sistemas;
            });
        },
        getEquipos() {
            axios.get("/admin/equipos").then((response) => {
                this.listEquipos = response.data.equipos;
            });
        },
        setRegistroModal() {
            this.enviando = true;
            try {
                this.textoBtn = "Enviando...";
                let url = "/admin/subunidads";
                let config = {
                    headers: {
                        "Content-Type": "multipart/form-data",
                    },
                };
                let formdata = new FormData();
                formdata.append(
                    "area_id",
                    this.subunidad.area_id ? this.subunidad.area_id : ""
                );
                formdata.append(
                    "sistema_id",
                    this.subunidad.sistema_id ? this.subunidad.sistema_id : ""
                );
                formdata.append(
                    "equipo_id",
                    this.subunidad.sistema_id ? this.subunidad.sistema_id : ""
                );
                formdata.append(
                    "codigo",
                    this.subunidad.codigo ? this.subunidad.codigo : ""
                );
                formdata.append(
                    "nombre",
                    this.subunidad.nombre ? this.subunidad.nombre : ""
                );
                formdata.append(
                    "numero",
                    this.subunidad.numero ? this.subunidad.numero : ""
                );
                formdata.append(
                    "codigo2",
                    this.subunidad.codigo2 ? this.subunidad.codigo2 : ""
                );

                if (this.accion == "edit") {
                    url = "/admin/subunidads/" + this.subunidad.id;
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
                            this.limpiaSubunidad();
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
        generarCodigo2() {
            if (this.subunidad.codigo != "" && this.subunidad.numero != "") {
                this.subunidad.codigo2 =
                    this.subunidad.codigo.toUpperCase() +
                    "-" +
                    this.subunidad.numero.toUpperCase();
            } else {
                this.subunidad.codigo2 = "";
            }
        },
        // Dialog/modal
        cierraModal() {
            this.bModal = false;
            this.$emit("close");
        },
        limpiaSubunidad() {
            this.errors = [];
            this.subunidad.area_id = "";
            this.subunidad.sistema_id = "";
            this.subunidad.codigo = "";
            this.subunidad.nombre = "";
            this.subunidad.numero = "";
            this.subunidad.codigo2 = "";
        },
    },
};
</script>

<style></style>
