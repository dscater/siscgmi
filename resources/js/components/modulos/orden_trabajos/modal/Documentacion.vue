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
                    <b-skeleton-wrapper
                        :loading="!oOrdenGenerada"
                        class="w-100"
                    >
                        <template #loading>
                            <b-skeleton-table
                                :rows="3"
                                :columns="3"
                                :table-props="{ bordered: true, striped: true }"
                            >
                            </b-skeleton-table>
                        </template>
                        <form v-if="oOrdenGenerada">
                            <div class="row">
                                <div class="form-group col-md-6">
                                    <label
                                        :class="{
                                            'text-danger': errors.file,
                                        }"
                                        >Seleccionar Archivo
                                        <span>
                                            <a
                                                v-if="
                                                    oOrdenGenerada.url_archivo
                                                "
                                                :href="
                                                    oOrdenGenerada.url_archivo
                                                "
                                                target="_blank"
                                                >Descargar actual</a
                                            ><span v-else>*</span>
                                        </span></label
                                    >
                                    <input
                                        type="file"
                                        class="form-control"
                                        :class="{
                                            'is-invalid': errors.file,
                                        }"
                                        ref="input_file"
                                        @change="cargaArchivo"
                                    />
                                    <span
                                        class="error invalid-feedback"
                                        v-if="errors.file"
                                        v-text="errors.file[0]"
                                    ></span>
                                </div>
                                <div class="form-group col-md-6">
                                    <label
                                        :class="{
                                            'text-danger':
                                                errors.descripcion_documentacion,
                                        }"
                                        >Descripción</label
                                    >
                                    <el-input
                                        type="textarea"
                                        autosize
                                        :class="{
                                            'is-invalid':
                                                errors.descripcion_documentacion,
                                        }"
                                        v-model="
                                            oOrdenGenerada.descripcion_documentacion
                                        "
                                    >
                                    </el-input>
                                    <span
                                        class="error invalid-feedback"
                                        v-if="errors.descripcion_documentacion"
                                        v-text="
                                            errors.descripcion_documentacion[0]
                                        "
                                    ></span>
                                </div>
                            </div>
                        </form>
                    </b-skeleton-wrapper>
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
                    descripcion_documentacion_documentacion: "",
                    comentario: "",
                    detalle_documentacions: [],
                    detalle_documentacions: [],
                    detalle_documentacions: [],
                },
            },
        },
    },
    watch: {
        muestra_modal: function (newVal, oldVal) {
            this.errors = [];
            this.oOrdenGenerada = null;
            if (newVal) {
                this.bModal = true;
                this.getOrdengenerada();
            } else {
                this.bModal = false;
            }
        },
    },
    computed: {
        tituloModal() {
            return "DOCUMENTACIÓN";
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
            oOrdenGenerada: null,
        };
    },
    mounted() {
        this.bModal = this.muestra_modal;
    },
    methods: {
        getOrdengenerada() {
            axios
                .get(
                    "/admin/orden_generadas/getByOrdenTrabajo/" +
                        this.orden_trabajo.id
                )
                .then((response) => {
                    this.oOrdenGenerada = response.data;
                });
        },
        cargaArchivo(e) {
            this.oOrdenGenerada.file = e.target.files[0];
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
                if (this.oOrdenGenerada.file) {
                    formdata.append("file", this.oOrdenGenerada.file);
                }
                if (
                    this.oOrdenGenerada.descripcion_documentacion &&
                    this.oOrdenGenerada.descripcion_documentacion.trim() != ""
                ) {
                    formdata.append(
                        "descripcion_documentacion",
                        this.oOrdenGenerada.descripcion_documentacion
                    );
                }

                let url =
                    "/admin/orden_generadas/actualizaDocumentacion/" +
                    this.oOrdenGenerada.id;
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
                            console.log(response.data);
                            this.$emit(
                                "envioModal",
                                response.data.orden_generada
                            );
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
            this.$refs.input_file.value = null;
        },
    },
};
</script>

<style></style>
