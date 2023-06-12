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
                                        'text-danger': errors.tipo_mo,
                                    }"
                                    >Tipo de MO*</label
                                >
                                <el-select
                                    class="w-100"
                                    :class="{ 'is-invalid': errors.tipo_mo }"
                                    v-model="personal.tipo_mo"
                                    clearable
                                >
                                    <el-option
                                        v-for="(item, index) in listMo"
                                        :key="index"
                                        :value="item"
                                        :label="item"
                                    ></el-option>
                                </el-select>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.tipo_mo"
                                    v-text="errors.tipo_mo[0]"
                                ></span>
                            </div>
                            <div
                                class="form-group col-md-6"
                                v-if="personal.tipo_mo == 'USUARIOS'"
                            >
                                <label
                                    :class="{
                                        'text-danger': errors.user_id,
                                    }"
                                    >Seleccionar Usuario (Auxiliar de
                                    Mantenimiento)*</label
                                >
                                <el-select
                                    class="w-100"
                                    :class="{ 'is-invalid': errors.user_id }"
                                    v-model="personal.user_id"
                                    clearable
                                    @change="obtieneUsuario"
                                >
                                    <el-option
                                        v-for="item in listUsers"
                                        :key="item.id"
                                        :value="item.id"
                                        :label="item.full_name"
                                    ></el-option>
                                </el-select>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.user_id"
                                    v-text="errors.user_id[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.razon_social,
                                    }"
                                    >Razón social*</label
                                >
                                <el-input
                                    placeholder="Razón social"
                                    :class="{
                                        'is-invalid': errors.razon_social,
                                    }"
                                    v-model="personal.razon_social"
                                    clearable
                                >
                                </el-input>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.razon_social"
                                    v-text="errors.razon_social[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.nro_doc,
                                    }"
                                    >Número de documento</label
                                >
                                <el-input
                                    placeholder="Número de documento"
                                    :class="{ 'is-invalid': errors.nro_doc }"
                                    v-model="personal.nro_doc"
                                >
                                </el-input>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.nro_doc"
                                    v-text="errors.nro_doc[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.especialidad,
                                    }"
                                    >Especialidad</label
                                >
                                <el-input
                                    placeholder="Especialidad"
                                    :class="{
                                        'is-invalid': errors.especialidad,
                                    }"
                                    v-model="personal.especialidad"
                                >
                                </el-input>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.especialidad"
                                    v-text="errors.especialidad[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.correo,
                                    }"
                                    >Correo electrónico</label
                                >
                                <el-input
                                    placeholder="Correo electrónico"
                                    :class="{ 'is-invalid': errors.correo }"
                                    v-model="personal.correo"
                                >
                                </el-input>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.correo"
                                    v-text="errors.correo[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.telefono,
                                    }"
                                    >Teléfono/Celular</label
                                >
                                <b-form-tags
                                    input-id="tags-basic"
                                    placeholder="Teléfono/Celular"
                                    :class="{ 'is-invalid': errors.telefono }"
                                    v-model="personal.telefono"
                                    addButtonText="Añadir"
                                    separator=" ,;"
                                    remove-on-delete
                                ></b-form-tags>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.telefono"
                                    v-text="errors.telefono[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.domicilio,
                                    }"
                                    >Domicilio</label
                                >
                                <el-input
                                    placeholder="Domicilio"
                                    :class="{ 'is-invalid': errors.domicilio }"
                                    v-model="personal.domicilio"
                                >
                                </el-input>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.domicilio"
                                    v-text="errors.domicilio[0]"
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
        personal: {
            type: Object,
            default: {
                id: 0,
                tipo_mo: "",
                user_id: "",
                razon_social: "",
                nro_doc: "",
                especialidad: "",
                correo: "",
                telefono: [],
                domicilio: "",
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
            listMo: ["USUARIOS", "SERVICIOS", "TERCEROS"],
            listUsers: [],
            oUsuario: null,
        };
    },
    mounted() {
        this.bModal = this.muestra_modal;
        this.getUsuarios();
    },
    methods: {
        async getUsuarios() {
            try {
                const response = await this.getUsuariosTipo(
                    "AUXILIAR DE MANTENIMIENTO"
                );
                this.listUsers = response.data;
            } catch (error) {
                console.log(error);
            }
        },
        async obtieneUsuario() {
            try {
                if (this.personal.user_id != "") {
                    const response = await this.getUsuarioById(
                        this.personal.user_id
                    );
                    console.log(response);
                    this.oUsuario = response.data;
                    this.personal.nro_doc = this.oUsuario.ci;
                    this.personal.especialidad = this.oUsuario.especialidad;
                    this.personal.correo = this.oUsuario.correo;
                    this.personal.telefono = this.oUsuario.fono
                        ? this.oUsuario.fono.split("; ")
                        : "";
                    this.personal.domicilio = this.oUsuario.dir;
                } else {
                    this.oUsuario = null;
                }
            } catch (error) {
                console.log(error);
            }
        },
        setRegistroModal() {
            this.enviando = true;
            try {
                this.textoBtn = "Enviando...";
                let url = "/admin/personals";
                let config = {
                    headers: {
                        "Content-Type": "multipart/form-data",
                    },
                };
                let formdata = new FormData();
                if (this.personal.tipo_mo != "") {
                    formdata.append("tipo_mo", this.personal.tipo_mo);
                }

                if (
                    this.personal.user_id != "" &&
                    this.personal.tipo_mo == "USUARIOS"
                ) {
                    formdata.append("user_id", this.personal.user_id);
                }

                if (this.personal.razon_social != "") {
                    formdata.append("razon_social", this.personal.razon_social);
                }
                if (this.personal.nro_doc != "") {
                    formdata.append("nro_doc", this.personal.nro_doc);
                }
                if (this.personal.especialidad != "") {
                    formdata.append("especialidad", this.personal.especialidad);
                }
                if (this.personal.correo != "") {
                    formdata.append("correo", this.personal.correo);
                }
                if (this.personal.telefono != "") {
                    formdata.append(
                        "telefono",
                        this.personal.telefono.join("; ")
                    );
                }
                if (this.personal.domicilio != "") {
                    formdata.append("domicilio", this.personal.domicilio);
                }

                if (this.accion == "edit") {
                    url = "/admin/personals/" + this.personal.id;
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
                            this.limpiaPersonal();
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
            if (this.personal.codigo != "" && this.personal.numero != "") {
                this.personal.codigo2 =
                    this.personal.codigo.toUpperCase() +
                    "-" +
                    this.personal.numero.toUpperCase();
            } else {
                this.personal.codigo2 = "";
            }
        },
        // Dialog/modal
        cierraModal() {
            this.bModal = false;
            this.$emit("close");
        },
        limpiaPersonal() {
            this.errors = [];
            this.personal.tipo_mo = "";
            this.personal.user_id = "";
            this.personal.razon_social = "";
            this.personal.nro_doc = "";
            this.personal.especialidad = "";
            this.personal.correo = "";
            this.personal.telefono = [];
            this.personal.domicilio = "";
        },
    },
};
</script>

<style></style>
